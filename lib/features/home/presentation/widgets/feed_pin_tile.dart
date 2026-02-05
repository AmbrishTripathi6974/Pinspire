// Feed pin tile widget
// Pinterest editorial pin card for masonry grid — layered content, no gradients/shadows.

import 'package:flutter/material.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/core/utils/hero_tag_manager.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_quick_action_overlay.dart';

/// Pinterest-style feed pin card: portrait, variable height, masonry-compatible.
///
/// - Image fills the top section; three-dot menu in a bar below the image (not on it).
/// - Entire card is one container: image section + dots section below.
/// - Entire card tappable; subtle scale-down on tap; no ripple/splash.
/// - Long press shows quick action overlay with context-sensitive actions.
class FeedPinTile extends StatefulWidget {
  const FeedPinTile({
    super.key,
    required this.pin,
    this.onTap,
    this.onLongPress,
    this.onSave,
    this.onOptionsPressed,
    this.borderRadius = 10.0,
    this.showOptionsButton = true,
    this.showSaveIconOnImage = false,
    this.actionContext,
    this.onShare,
    this.onSend,
    this.onEdit,
    this.onSaveWithTouchPoint,
    this.heroTagContext,
    this.heroTagIndex,
  });

  final Pin pin;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onSave;
  final VoidCallback? onOptionsPressed;
  final double borderRadius;
  final bool showOptionsButton;
  /// When true, shows the save (pin) icon on the image like the search card design.
  final bool showSaveIconOnImage;
  /// Context for quick action overlay (determines which actions to show)
  final PinQuickActionContext? actionContext;
  /// Callback for Share action (visual only if not provided)
  final VoidCallback? onShare;
  /// Callback for Send action (visual only if not provided)
  final VoidCallback? onSend;
  /// Callback for Edit action (visual only if not provided)
  final VoidCallback? onEdit;
  /// Optional: called when Save is tapped from quick action overlay with touch point (e.g. for fly-to-saved animation). Invoked before [onSave].
  final void Function(Pin pin, Offset touchPoint)? onSaveWithTouchPoint;
  /// Optional Hero tag context for generating unique tags.
  /// If not provided, will use homeFeed context.
  final HeroTagContext? heroTagContext;
  
  /// Optional index for uniqueness when same pin appears multiple times.
  /// If provided, will be included in the Hero tag.
  final int? heroTagIndex;

  @override
  State<FeedPinTile> createState() => _FeedPinTileState();
}

class _FeedPinTileState extends State<FeedPinTile> {
  bool _isPressed = false;
  bool _isLongPressing = false;
  final GlobalKey _pinKey = GlobalKey();
  VoidCallback? _dismissOverlay;

  void _handleLongPressStart(LongPressStartDetails details) {
    if (widget.actionContext == null || widget.onSave == null) {
      // Fallback to original onLongPress if no context provided
      widget.onLongPress?.call();
      return;
    }

    if (!mounted) return;

    setState(() {
      _isLongPressing = true;
    });

    // Get global touch point
    final renderBox = _pinKey.currentContext?.findRenderObject() as RenderBox?;
    final touchPoint = renderBox != null
        ? renderBox.localToGlobal(details.localPosition)
        : details.globalPosition;

    // Show overlay and store dismiss callback. When Save is tapped, overlay calls onSaveWithTouchPoint if set (caller does animation + save), else onSave.
    PinQuickActionOverlay.show(
      context: context,
      pin: widget.pin,
      pinKey: _pinKey,
      touchPoint: touchPoint,
      actionContext: widget.actionContext!,
      onSave: () => widget.onSave!(),
      onSaveWithTouchPoint: (tp) => widget.onSaveWithTouchPoint?.call(widget.pin, tp),
      onShare: widget.onShare,
      onSend: widget.onSend,
      onEdit: widget.onEdit,
      onDismiss: () {
        // Reset state when overlay dismisses
        _dismissOverlay = null;
        if (mounted) {
          setState(() {
            _isLongPressing = false;
          });
        }
      },
    ).then((dismissCallback) {
      if (mounted) {
        _dismissOverlay = dismissCallback;
      }
    });
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    // Dismiss overlay when finger is lifted
    _dismissOverlay?.call();
    if (mounted) {
      setState(() {
        _isLongPressing = false;
        _dismissOverlay = null;
      });
    }
  }

  void _handleLongPressCancel() {
    // Dismiss overlay when long press is cancelled
    _dismissOverlay?.call();
    if (mounted) {
      setState(() {
        _isLongPressing = false;
        _dismissOverlay = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final placeholderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final errorIconColor = isDark ? Colors.grey.shade600 : Colors.grey;
    final iconColor = isDark ? Colors.white : Colors.black87;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use actual tile width so image size matches cell (same large size on home feed and saved pins)
        final width = constraints.maxWidth;
        final aspectRatio = widget.pin.aspectRatio.clamp(0.5, 2.0);
        final imageHeight = width / aspectRatio;
        final clampedHeight = imageHeight.clamp(100.0, 350.0).toDouble();

        return RepaintBoundary(
          child: GestureDetector(
            onTap: _isLongPressing ? null : widget.onTap,
            onLongPress: widget.actionContext == null ? widget.onLongPress : null,
            onLongPressStart: widget.actionContext != null ? _handleLongPressStart : null,
            onLongPressEnd: widget.actionContext != null ? _handleLongPressEnd : null,
            onLongPressCancel: widget.actionContext != null ? _handleLongPressCancel : null,
            onTapDown: (_) {
              if (!_isLongPressing) {
                setState(() => _isPressed = true);
              }
            },
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            child: AnimatedScale(
              scale: _isLongPressing ? 0.96 : (_isPressed ? 0.97 : 1.0),
              duration: Duration(milliseconds: _isLongPressing ? 150 : 100),
              curve: Curves.easeOut,
              child: Column(
                key: _pinKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(widget.borderRadius),
                          child: Hero(
                            tag: HeroTagManager.generateTag(
                              pinId: widget.pin.id,
                              context: widget.heroTagContext ?? HeroTagContext.homeFeed,
                              index: widget.heroTagIndex,
                            ),
                            child: PinterestCachedImage(
                              imageUrl: widget.pin.imageUrl,
                              height: clampedHeight,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.circular(widget.borderRadius),
                              placeholder: (_, __) => Container(
                                height: clampedHeight,
                                color: placeholderColor,
                                child: const _ShimmerEffect(),
                              ),
                              errorWidget: (_, __, ___) => Container(
                                height: clampedHeight,
                                color: placeholderColor,
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.image,
                                    color: errorIconColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                              // Optimized memory cache size for production
                              // 400px width provides good quality while keeping memory usage reasonable
                              memCacheWidth: 400,
                              memCacheHeight: (400 / widget.pin.aspectRatio).round().clamp(200, 800),
                            ),
                      ),
                    ),
                    if (widget.showSaveIconOnImage && widget.onSave != null)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: widget.onSave,
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                             padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Image.asset(
                              'assets/images/push_pin_icon.png',
                              width: 22,
                              height: 22,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (widget.showOptionsButton)
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 4),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: widget.onOptionsPressed,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 4),
                        child: Icon(
                          LucideIcons.moreHorizontal,
                          size: 22,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Provides a shared shimmer animation to all child widgets
/// This prevents creating an AnimationController per shimmer effect
class ShimmerProvider extends StatefulWidget {
  const ShimmerProvider({super.key, required this.child});
  
  final Widget child;

  static AnimationController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ShimmerInherited>()?.controller;
  }

  @override
  State<ShimmerProvider> createState() => _ShimmerProviderState();
}

class _ShimmerProviderState extends State<ShimmerProvider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ShimmerInherited(
      controller: _controller,
      child: widget.child,
    );
  }
}

class _ShimmerInherited extends InheritedWidget {
  const _ShimmerInherited({
    required this.controller,
    required super.child,
  });

  final AnimationController controller;

  @override
  bool updateShouldNotify(_ShimmerInherited oldWidget) => false;
}

/// Shimmer loading effect - uses shared animation from ShimmerProvider.
/// Greyish colors (no theme tint) for a neutral, production-style loading state.
class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    final controller = ShimmerProvider.of(context);

    if (controller == null) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [baseColor, highlightColor, baseColor],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0 + 2.0 * controller.value, 0),
              end: Alignment(1.0 + 2.0 * controller.value, 0),
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// Pin tile with more details (for profile/board views)
class DetailedPinTile extends StatelessWidget {
  const DetailedPinTile({
    super.key,
    required this.pin,
    this.onTap,
    this.onSave,
    this.showDescription = true,
    this.showPhotographer = true,
  });

  final Pin pin;
  final VoidCallback? onTap;
  final VoidCallback? onSave;
  final bool showDescription;
  final bool showPhotographer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FeedPinTile(
          pin: pin,
          onTap: onTap,
          onSave: onSave,
        ),
        if (showDescription && pin.description != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              pin.description!,
              style: theme.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        if (showPhotographer && pin.photographer != 'Unknown') ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              pin.photographer,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }
}
