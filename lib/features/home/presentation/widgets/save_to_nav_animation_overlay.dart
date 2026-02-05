// Pinterest-style save animation: hero-style miniature flies from the pin image
// to the Saved nav icon, holds, shakes, fades, then a burst celebration and completes.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pinterest/core/save_animation/saved_nav_key.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';

/// Pinterest-like save animation overlay: a small image copy moves from
/// [startPosition] to the Saved navbar icon and then disappears.
class SaveToNavAnimationOverlay {
  SaveToNavAnimationOverlay._();

  /// Shows the fly-to-saved animation.
  ///
  /// [imageUrl] – pin image URL to show as the flying miniature.
  /// [startPosition] – global offset where the miniature appears (e.g. touch point).
  ///   If null, uses center of the screen.
  /// [onComplete] – called when the overlay is removed.
  static void show({
    required BuildContext context,
    required String imageUrl,
    Offset? startPosition,
    VoidCallback? onComplete,
  }) {
    final overlay = Overlay.of(context);
    final screenSize = MediaQuery.of(context).size;
    final start = startPosition ?? Offset(screenSize.width / 2, screenSize.height / 2);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => _SaveToNavAnimationWidget(
        imageUrl: imageUrl,
        startPosition: start,
        savedNavItemKey: savedNavItemKey,
        onComplete: () {
          entry.remove();
          onComplete?.call();
        },
      ),
      opaque: false,
    );
    overlay.insert(entry);
  }
}

/// Widget that runs the fly-to-saved animation.
class _SaveToNavAnimationWidget extends StatefulWidget {
  const _SaveToNavAnimationWidget({
    required this.imageUrl,
    required this.startPosition,
    required this.savedNavItemKey,
    required this.onComplete,
  });

  final String imageUrl;
  final Offset startPosition;
  final GlobalKey savedNavItemKey;
  final VoidCallback onComplete;

  @override
  State<_SaveToNavAnimationWidget> createState() =>
      _SaveToNavAnimationWidgetState();
}

class _SaveToNavAnimationWidgetState extends State<_SaveToNavAnimationWidget>
    with TickerProviderStateMixin {
  /// Portrait miniature: taller than wide, all edges rounded.
  static const double _miniatureWidth = 44.0;
  static const double _miniatureHeight = 66.0;
  static const double _cornerRadius = 10.0;
  static const Duration _initialDelay = Duration(milliseconds: 320);
  /// Total duration: fly + hold + shake + fade (before celebration burst)
  static const Duration _totalDuration = Duration(milliseconds: 2100);
  static const Curve _flyCurve = Curves.easeOutCubic;
  static const double _burstSize = 200.0;
  static const Duration _burstDuration = Duration(milliseconds: 1200);
  static const int _burstParticleCount = 12;
  static const double _burstRadius = 70.0;
  static const List<Color> _burstColors = [
    Color(0xFFE60023), // Pinterest red
    Color(0xFFFFD700), // gold
    Color(0xFF00C853), // green
    Color(0xFF2196F3), // blue
  ];

  /// Phase boundaries (0–1): fly ends, hold ends, shake ends, then fade to end
  static const double _flyEnd = 0.42;   // ~880ms fly
  static const double _holdEnd = 0.64;   // ~460ms hold at icon
  static const double _shakeEnd = 0.83; // ~400ms shake
  static const double _shakeAmount = 10.0;
  static const int _shakeOscillations = 3;

  late AnimationController _controller;
  AnimationController? _burstController;
  Offset? _endPosition;
  bool _showConfetti = false;
  void Function(AnimationStatus)? _mainStatusListener;
  void Function(AnimationStatus)? _burstStatusListener;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _totalDuration,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _resolveEndAndStart());
  }

  void _resolveEndAndStart() {
    if (!mounted) return;
    _endPosition = _getSavedIconHoverPosition();
    if (_endPosition == null) {
      final size = MediaQuery.of(context).size;
      final padding = MediaQuery.of(context).padding;
      _endPosition = Offset(
        size.width * 0.9,
        size.height - padding.bottom - 56 - _miniatureHeight / 2 - 6,
      );
    }
    if (!mounted) return;
    _mainStatusListener = (status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _showConfetti = true);
        _startBurstCelebration();
      }
    };
    _controller.addStatusListener(_mainStatusListener!);
    setState(() {});
    Future.delayed(_initialDelay, () {
      if (!mounted) return;
      _controller.forward();
    });
  }

  void _startBurstCelebration() {
    if (!mounted) return;
    _burstController = AnimationController(
      vsync: this,
      duration: _burstDuration,
    );
    _burstStatusListener = (status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    };
    _burstController!.addStatusListener(_burstStatusListener!);
    _burstController!.forward();
    setState(() {});
  }

  (Offset position, double scale, double opacity) _getValuesForProgress(double progress, Offset end) {
    if (progress < _flyEnd) {
      double t = (progress / _flyEnd).clamp(0.0, 1.0);
      t = _flyCurve.transform(t);
      final position = Offset.lerp(widget.startPosition, end, t)!;
      double scaleT = (progress / (_flyEnd * 0.42)).clamp(0.0, 1.0);
      scaleT = Curves.easeOutCubic.transform(scaleT);
      final scale = 0.35 + (1.0 - 0.35) * scaleT;
      double opacityT = (progress / (_flyEnd * 0.28)).clamp(0.0, 1.0);
      final opacity = 0.7 + 0.3 * opacityT;
      return (position, scale, opacity);
    } else if (progress < _holdEnd) {
      return (end, 1.0, 1.0);
    } else if (progress < _shakeEnd) {
      double shakeT = (progress - _holdEnd) / (_shakeEnd - _holdEnd);
      double shakeX = _shakeAmount * math.sin(shakeT * _shakeOscillations * 2 * math.pi);
      return (end + Offset(shakeX, 0), 1.0, 1.0);
    } else {
      double fadeT = (progress - _shakeEnd) / (1.0 - _shakeEnd);
      return (end, 1.0, (1.0 - fadeT).clamp(0.0, 1.0));
    }
  }

  /// Position so the miniature hovers over the Saved tab (sits above the nav bar, centered on the icon).
  Offset? _getSavedIconHoverPosition() {
    final keyContext = widget.savedNavItemKey.currentContext;
    if (keyContext == null) return null;
    final box = keyContext.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    final pos = box.localToGlobal(Offset.zero);
    final centerX = pos.dx + box.size.width / 2;
    // Place miniature above the nav item: bottom of card just above the top of the tab
    const gapAboveBar = 6.0;
    final centerY = pos.dy - _miniatureHeight / 2 - gapAboveBar;
    return Offset(centerX, centerY);
  }

  @override
  void dispose() {
    if (_mainStatusListener != null) {
      _controller.removeStatusListener(_mainStatusListener!);
      _mainStatusListener = null;
    }
    _controller.dispose();
    if (_burstController != null && _burstStatusListener != null) {
      _burstController!.removeStatusListener(_burstStatusListener!);
      _burstStatusListener = null;
    }
    _burstController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_endPosition == null) {
      return const SizedBox.shrink();
    }

    final end = _endPosition!;

    // After main animation: show burst celebration at Saved icon (avoids Lottie frame assertion)
    if (_showConfetti && _burstController != null) {
      return IgnorePointer(
        child: AnimatedBuilder(
          animation: _burstController!,
          builder: (context, _) {
            final t = _burstController!.value;
            final curveT = Curves.easeOut.transform(t);
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: end.dx - _burstSize / 2,
                  top: end.dy - _burstSize / 2,
                  child: SizedBox(
                    width: _burstSize,
                    height: _burstSize,
                    child: CustomPaint(
                      painter: _BurstPainter(
                        progress: curveT,
                        particleCount: _burstParticleCount,
                        radius: _burstRadius,
                        colors: _burstColors,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final (position, scale, opacity) = _getValuesForProgress(_controller.value, end);
        final w = _miniatureWidth * scale;
        final h = _miniatureHeight * scale;
        return IgnorePointer(
          child: Stack(
            children: [
              Positioned(
                left: position.dx - w / 2,
                top: position.dy - h / 2,
                child: Opacity(
                  opacity: opacity,
                  child: Material(
                    type: MaterialType.transparency,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_cornerRadius),
                      child: SizedBox(
                        width: w,
                        height: h,
                        child: PinterestCachedImage(
                          imageUrl: widget.imageUrl,
                          fit: BoxFit.cover,
                          memCacheWidth: 88,
                          memCacheHeight: 132,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Paints a burst of colored particles (confetti-like) from the center.
class _BurstPainter extends CustomPainter {
  _BurstPainter({
    required this.progress,
    required this.particleCount,
    required this.radius,
    required this.colors,
  });

  final double progress;
  final int particleCount;
  final double radius;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * math.pi;
      final dist = radius * progress;
      final x = center.dx + math.cos(angle) * dist;
      final y = center.dy + math.sin(angle) * dist;
      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      final color = colors[i % colors.length].withValues(alpha: opacity);
      final dotRadius = 4.0 * (1.0 - progress * 0.5);
      canvas.drawCircle(Offset(x, y), dotRadius, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant _BurstPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

