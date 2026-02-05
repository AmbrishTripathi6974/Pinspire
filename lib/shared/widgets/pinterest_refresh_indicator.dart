// Pinterest-style pull-to-refresh indicator
// Custom refresh animation with smooth physics
//
// REFRESH BEHAVIOR (strict):
// - Refresh triggers ONLY via explicit pull-to-refresh (pull from top, past threshold, release).
// - Pull must start from absolute scroll offset ≈ 0; small scrolls do NOT trigger refresh.
// - Refresh does NOT trigger on: tab switch, page rebuild, navigation back, or scroll position changes.
// - Indicator appears only after sufficient pull; movement feels resistant and intentional.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';

/// Pinterest-style pull-to-refresh indicator
///
/// Features:
/// - Triggers only on explicit pull from top (scroll offset ≈ 0), past resistance threshold
/// - Custom refresh animation (not default Material)
/// - Weighted drag resistance; no sudden spinner; no layout jump when refresh completes
/// - Works with any scrollable child
class PinterestRefreshIndicator extends StatefulWidget {
  const PinterestRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.displacement = 60.0,
    this.edgeOffset = 0.0,
    this.triggerDistance = 100.0,
    this.indicatorColor,
    this.backgroundColor,
  });

  /// The scrollable child widget
  final Widget child;

  /// Callback when refresh is triggered
  final Future<void> Function() onRefresh;

  /// Distance from top where indicator appears
  final double displacement;

  /// Additional offset from the edge
  final double edgeOffset;

  /// Distance to pull before refresh triggers
  final double triggerDistance;

  /// Color of the refresh indicator
  final Color? indicatorColor;

  /// Background color of the indicator container
  final Color? backgroundColor;

  @override
  State<PinterestRefreshIndicator> createState() =>
      _PinterestRefreshIndicatorState();
}

/// Phase of the post-release transition (settle to lock, then exit).
enum _TransitionPhase { none, settling, refreshing, exiting }

class _PinterestRefreshIndicatorState extends State<PinterestRefreshIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _transitionController;

  _RefreshState _refreshState = _RefreshState.idle;
  double _dragOffset = 0.0;
  bool _isRefreshing = false;

  /// Transition: smooth settle to lock position, then smooth exit.
  _TransitionPhase _transitionPhase = _TransitionPhase.none;
  double _transitionStartOffset = 0.0;
  double _transitionEndOffset = 0.0;

  /// Start offset for reset spring (so listener can map normalized value to offset).
  double _resetStartOffset = 0.0;

  /// Last known scroll position. Used to ensure overscroll is only accepted when at top.
  double _lastScrollPixels = 0.0;

  /// Pull is only valid when scroll is at absolute top (offset ≈ 0).
  static const double _atTopThreshold = 2.0;
  /// Indicator appears only after sufficient pull (resistant, intentional feel).
  static const double _minPullToShowIndicator = 28.0;
  /// Minimum overscroll (px) before we accumulate from ScrollUpdate (avoids tiny bounces).
  static const double _minOverscrollToAccumulate = 10.0;
  /// Minimum scroll delta (px) to count as intentional pull when at top.
  static const double _minDeltaToAccumulate = 4.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..addListener(_onTransitionTick);
  }

  @override
  void dispose() {
    _transitionController.removeListener(_onTransitionTick);
    _transitionController.dispose();
    _animationController.removeListener(_onResetAnimation);
    _animationController.dispose();
    super.dispose();
  }

  void _onTransitionTick() {
    if (!mounted) return;
    final t = Curves.easeOutCubic.transform(_transitionController.value);
    setState(() {
      _dragOffset = _transitionStartOffset + t * (_transitionEndOffset - _transitionStartOffset);
    });
    if (_transitionController.isCompleted) _onTransitionComplete();
  }

  void _onTransitionComplete() {
    if (!mounted) return;
    if (_transitionPhase == _TransitionPhase.settling) {
      _transitionPhase = _TransitionPhase.refreshing;
      setState(() {
        _dragOffset = widget.displacement;
        _isRefreshing = true;
        _refreshState = _RefreshState.refreshing;
      });
    } else if (_transitionPhase == _TransitionPhase.exiting) {
      _transitionPhase = _TransitionPhase.none;
      setState(() {
        _dragOffset = 0.0;
        _isRefreshing = false;
        _refreshState = _RefreshState.idle;
      });
    }
  }

  /// Handles notification from scroll events.
  /// Refresh triggers ONLY via explicit pull-to-refresh: scroll at 0, pull past threshold, release.
  /// Not bound to scroll position changes; no refresh on tab switch, rebuild, or navigation.
  bool _handleScrollNotification(ScrollNotification notification) {
    if (_isRefreshing) return false;

    if (notification is OverscrollNotification) {
      // Only accept overscroll when scroll was at absolute top (pull started from 0).
      if (_lastScrollPixels > _atTopThreshold) return false;
      if (notification.overscroll < 0) {
        final amount = notification.overscroll.abs();
        if (amount >= _minDeltaToAccumulate) {
          _handleOverscroll(amount);
        }
      }
    } else if (notification is ScrollUpdateNotification) {
      final pixels = notification.metrics.pixels;
      final delta = notification.scrollDelta ?? 0.0;
      _lastScrollPixels = pixels;

      // Must be at absolute top (offset ≈ 0) to allow pull-to-refresh; otherwise reset.
      if (pixels > _atTopThreshold) {
        if (_dragOffset > 0) _resetDrag();
        return false;
      }

      // At top: only accumulate intentional pull, not tiny or accidental movements.
      if (pixels < 0) {
        final overscroll = pixels.abs();
        if (overscroll >= _minOverscrollToAccumulate) {
          _handleOverscroll(overscroll * 0.1);
        }
      } else if (delta < 0 && delta.abs() >= _minDeltaToAccumulate) {
        _handleOverscroll(delta.abs() * 0.5);
      }

      if (_dragOffset > 0 && pixels > _atTopThreshold) {
        _resetDrag();
      }
    } else if (notification is ScrollEndNotification) {
      _handleScrollEnd();
    }

    return false;
  }

  /// Handles overscroll (pulling down past the top)
  void _handleOverscroll(double delta) {
    if (_isRefreshing) return;

    setState(() {
      // Apply resistance curve so pull feels weighted and intentional
      final resistance = _calculateResistance(_dragOffset);
      _dragOffset += delta * resistance;
      _dragOffset = _dragOffset.clamp(0.0, widget.triggerDistance * 1.5);

      if (_dragOffset >= widget.triggerDistance) {
        _refreshState = _RefreshState.armed;
      } else if (_dragOffset > 0) {
        _refreshState = _RefreshState.drag;
      }
    });
  }

  /// Calculates drag resistance for weighted, intentional feel.
  /// Starts low so initial pull moves indicator less; eases as user commits (pulls further).
  double _calculateResistance(double offset) {
    final progress = (offset / widget.triggerDistance).clamp(0.0, 1.0);
    return math.max(0.3, 0.4 + (progress * 0.4));
  }

  /// Handles scroll end - triggers refresh or resets
  void _handleScrollEnd() {
    if (_isRefreshing) return;

    if (_refreshState == _RefreshState.armed) {
      _triggerRefresh();
    } else {
      _resetDrag();
    }
  }

  /// Triggers the refresh callback. Refresh starts ONLY on release; indicator settles smoothly then locks.
  Future<void> _triggerRefresh() async {
    if (_isRefreshing) return;

    // Smooth settle: animate indicator from current pull position to lock position (no snap).
    _transitionPhase = _TransitionPhase.settling;
    _transitionStartOffset = _dragOffset;
    _transitionEndOffset = widget.displacement;
    _transitionController.duration = const Duration(milliseconds: 200);
    await _transitionController.forward(from: 0.0);

    if (!mounted) return;
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        await _completeRefresh();
      }
    }
  }

  /// Completes refresh: animate indicator out gracefully (easeOut), then clear state.
  Future<void> _completeRefresh() async {
    if (!mounted) return;

    _transitionPhase = _TransitionPhase.exiting;
    _transitionStartOffset = widget.displacement;
    _transitionEndOffset = 0.0;
    _transitionController.duration = const Duration(milliseconds: 320);
    _transitionController.reset();
    await _transitionController.forward();

    if (mounted) {
      // _onTransitionComplete already cleared state when exit animation finished
    }
  }

  /// Resets drag with spring simulation (elastic, Cupertino-like).
  void _resetDrag() {
    if (_dragOffset == 0) return;

    _resetStartOffset = _dragOffset;
    // Normalized spring 1 → 0 so controller stays in [0, 1]; map to _dragOffset.
    final simulation = SpringSimulation(
      const SpringDescription(mass: 1, stiffness: 380, damping: 26),
      1,
      0,
      0,
    );

    _animationController.animateWith(simulation).whenCompleteOrCancel(() {
      if (mounted) {
        setState(() {
          _dragOffset = 0;
          _refreshState = _RefreshState.idle;
        });
        _animationController.removeListener(_onResetAnimation);
      }
    });
    _animationController.addListener(_onResetAnimation);
  }

  void _onResetAnimation() {
    if (!mounted) return;
    setState(() => _dragOffset = _resetStartOffset * _animationController.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorColor =
        widget.indicatorColor ?? theme.colorScheme.primary;

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Stack(
        children: [
          // Main content with padding for indicator
          Positioned.fill(
            child: widget.child,
          ),

          // Refresh indicator (visible when pulling or during refresh/transition)
          if (_dragOffset >= _minPullToShowIndicator ||
              _isRefreshing ||
              _transitionPhase != _TransitionPhase.none)
            Positioned(
              top: widget.edgeOffset,
              left: 0,
              right: 0,
              child: _buildIndicator(indicatorColor: indicatorColor),
            ),
        ],
      ),
    );
  }

  /// Pull progress 0→1, with curve so indicator fades/scales in gradually (no sudden appearance).
  double get _pullProgress =>
      (_dragOffset / widget.triggerDistance).clamp(0.0, 1.0);

  /// Display progress: eased so first part of pull shows little, then progressive.
  double get _displayProgress => Curves.easeOut.transform(_pullProgress);

  Widget _buildIndicator({required Color indicatorColor}) {
    final progress = _pullProgress;
    final isLocked =
        _isRefreshing ||
        _transitionPhase == _TransitionPhase.settling ||
        _transitionPhase == _TransitionPhase.refreshing;
    final isExiting = _transitionPhase == _TransitionPhase.exiting;

    double scale;
    double opacity;
    if (isLocked) {
      scale = 1.0;
      opacity = 1.0;
    } else if (isExiting && widget.displacement > 0) {
      // Exit: fade out with position (no jump from locked state).
      final exitProgress = (_dragOffset / widget.displacement).clamp(0.0, 1.0);
      scale = exitProgress;
      opacity = exitProgress;
    } else {
      scale = 0.5 + 0.5 * _displayProgress;
      opacity = _displayProgress.clamp(0.0, 1.0);
    }

    return Transform.translate(
      offset: Offset(0, _dragOffset - widget.displacement),
      child: Center(
        child: Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: SizedBox(
              width: 44,
              height: 44,
              child: _buildIndicatorContent(
                progress: progress,
                color: indicatorColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicatorContent({
    required double progress,
    required Color color,
  }) {
    if (_refreshState == _RefreshState.refreshing) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: PinterestDotsLoader.compact(),
      );
    }

    // Custom progress indicator
    return _PinterestProgressIndicator(
      progress: progress,
      color: color,
      isArmed: _refreshState == _RefreshState.armed,
    );
  }
}

/// Custom progress indicator with Pinterest-style animation
class _PinterestProgressIndicator extends StatelessWidget {
  const _PinterestProgressIndicator({
    required this.progress,
    required this.color,
    required this.isArmed,
  });

  final double progress;
  final Color color;
  final bool isArmed;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PinterestProgressPainter(
        progress: progress,
        color: color,
        isArmed: isArmed,
      ),
    );
  }
}

class _PinterestProgressPainter extends CustomPainter {
  _PinterestProgressPainter({
    required this.progress,
    required this.color,
    required this.isArmed,
  });

  final double progress;
  final Color color;
  final bool isArmed;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 8;

    // Background circle
    final bgPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );

    // Checkmark when armed
    if (isArmed) {
      final checkPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final checkPath = Path();
      final checkSize = radius * 0.5;
      checkPath.moveTo(center.dx - checkSize * 0.5, center.dy);
      checkPath.lineTo(center.dx - checkSize * 0.1, center.dy + checkSize * 0.4);
      checkPath.lineTo(center.dx + checkSize * 0.5, center.dy - checkSize * 0.3);

      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(_PinterestProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        color != oldDelegate.color ||
        isArmed != oldDelegate.isArmed;
  }
}

/// Internal refresh states
enum _RefreshState {
  idle,
  drag,
  armed,
  refreshing,
}

/// Alternative: Sliver-based refresh indicator for use with CustomScrollView
class PinterestSliverRefreshIndicator extends StatefulWidget {
  const PinterestSliverRefreshIndicator({
    super.key,
    required this.onRefresh,
    this.refreshTriggerPullDistance = 100.0,
    this.refreshIndicatorExtent = 60.0,
  });

  final Future<void> Function() onRefresh;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;

  @override
  State<PinterestSliverRefreshIndicator> createState() =>
      _PinterestSliverRefreshIndicatorState();
}

class _PinterestSliverRefreshIndicatorState
    extends State<PinterestSliverRefreshIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  _RefreshState _refreshState = _RefreshState.idle;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() => _refreshState = _RefreshState.refreshing);

    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        setState(() => _refreshState = _RefreshState.idle);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final overscroll = constraints.overlap < 0
            ? constraints.overlap.abs()
            : constraints.precedingScrollExtent < 0
                ? constraints.precedingScrollExtent.abs()
                : 0.0;

        final progress =
            (overscroll / widget.refreshTriggerPullDistance).clamp(0.0, 1.0);

        // Check if should trigger refresh
        if (overscroll >= widget.refreshTriggerPullDistance &&
            _refreshState == _RefreshState.idle) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _refreshState == _RefreshState.idle) {
              _handleRefresh();
            }
          });
        }

        return SliverToBoxAdapter(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: _refreshState == _RefreshState.refreshing
                ? widget.refreshIndicatorExtent
                : overscroll.clamp(0.0, widget.refreshIndicatorExtent),
            child: Center(
              child: _refreshState == _RefreshState.refreshing
                  ? const PinterestDotsLoader.compact()
                  : Opacity(
                      opacity: progress,
                      child: Transform.scale(
                        scale: 0.7 + (progress * 0.3),
                        child: _PinterestProgressIndicator(
                          progress: progress,
                          color: theme.colorScheme.primary,
                          isArmed: progress >= 1.0,
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
