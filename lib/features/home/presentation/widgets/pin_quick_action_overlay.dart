// Pinterest-style quick action overlay
// Floating action overlay that appears on long press of a Pin
// Shows context-sensitive action buttons with smooth animations

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

/// Context type for determining which actions to show
enum PinQuickActionContext {
  /// Home feed context - shows Save, Share, Send
  homeFeed,
  
  /// Saved pins or board section - shows Save, Edit, Share, Send
  savedPins,
  
  /// Board section (same as savedPins)
  boardSection,
}

/// Pinterest-style quick action overlay
/// 
/// Appears on long press of a Pin, showing context-sensitive action buttons.
/// Overlay is positioned relative to the Pin location and animates smoothly.
class PinQuickActionOverlay {
  /// Shows the quick action overlay for a Pin
  /// 
  /// Returns a Future that completes with a dismiss callback function
  /// 
  /// [context] - BuildContext for overlay insertion
  /// [pin] - The Pin being acted upon
  /// [pinKey] - GlobalKey of the Pin widget for position calculation
  /// [touchPoint] - Global position where user touched/long-pressed
  /// [actionContext] - Context type determining which actions to show
  /// [onSave] - Callback when Save is tapped (required, functional)
  /// [onShare] - Callback when Share is tapped (optional, visual only)
  /// [onSend] - Callback when Send is tapped (optional, visual only)
  /// [onEdit] - Callback when Edit is tapped (optional, visual only)
  /// [onDismiss] - Optional callback when overlay is dismissed
  /// [onSaveWithTouchPoint] - Optional callback when Save is tapped, called with touch point before [onSave] (e.g. for fly-to-saved animation)
  static Future<VoidCallback> show({
    required BuildContext context,
    required Pin pin,
    required GlobalKey pinKey,
    required Offset touchPoint,
    required PinQuickActionContext actionContext,
    required VoidCallback onSave,
    VoidCallback? onShare,
    VoidCallback? onSend,
    VoidCallback? onEdit,
    VoidCallback? onDismiss,
    void Function(Offset touchPoint)? onSaveWithTouchPoint,
  }) async {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    late VoidCallback dismissCallback;
    
    overlayEntry = OverlayEntry(
      builder: (context) => _PinQuickActionOverlayWidget(
        pin: pin,
        pinKey: pinKey,
        touchPoint: touchPoint,
        actionContext: actionContext,
        onSave: onSave,
        onShare: onShare,
        onSend: onSend,
        onEdit: onEdit,
        onDismiss: () {
          overlayEntry.remove();
          onDismiss?.call();
        },
        onSaveWithTouchPoint: onSaveWithTouchPoint,
      ),
      opaque: false,
    );
    
    overlay.insert(overlayEntry);
    
    // Return dismiss callback
    dismissCallback = () {
      overlayEntry.remove();
      onDismiss?.call();
    };
    
    return dismissCallback;
  }
}


/// Overlay widget that handles positioning, animations, and rendering
class _PinQuickActionOverlayWidget extends StatefulWidget {
  const _PinQuickActionOverlayWidget({
    required this.pin,
    required this.pinKey,
    required this.touchPoint,
    required this.actionContext,
    required this.onSave,
    this.onShare,
    this.onSend,
    this.onEdit,
    required this.onDismiss,
    this.onSaveWithTouchPoint,
  });

  final Pin pin;
  final GlobalKey pinKey;
  final Offset touchPoint; // Global position where user touched
  final PinQuickActionContext actionContext;
  final VoidCallback onSave;
  final VoidCallback? onShare;
  final VoidCallback? onSend;
  final VoidCallback? onEdit;
  final VoidCallback onDismiss;
  /// Called when Save is tapped, with the touch point (e.g. for fly-to-saved animation). Invoked before [onSave].
  final void Function(Offset touchPoint)? onSaveWithTouchPoint;

  @override
  State<_PinQuickActionOverlayWidget> createState() =>
      _PinQuickActionOverlayWidgetState();
}

class _PinQuickActionOverlayWidgetState
    extends State<_PinQuickActionOverlayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _overlayOpacity;
  late Animation<double> _overlayScale;
  late Animation<double> _backgroundOpacity;
  bool _isDismissing = false;
  int? _focusedButtonIndex;
  bool _showMoreHorizontal = false; // Show more options when Save is hovered
  bool _isBottomTouch = false; // Track if touch is on bottom part of image
  bool _isTopTouch = false; // Track if touch is on top part of image
  Offset? _currentPanPosition; // Track current pan position for rotation calculation

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150), // Faster, no delay
    );

    // Overlay fade and scale animation - instant appearance
    _overlayOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _overlayScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Background dimming animation
    _backgroundOpacity = Tween<double>(begin: 0.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Listen for back button
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupBackButtonListener();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Determine if touch is on left or right side of pin
    // This must be in didChangeDependencies() because it uses MediaQuery
    _determineTouchSide();
    
    // Start animation after dependencies are available
    if (!_controller.isAnimating && _controller.value == 0) {
      _controller.forward();
    }
  }

  /// Determine touch position relative to pin (top/bottom)
  /// Used for vertical arc adjustment to improve UX
  void _determineTouchSide() {
    final renderBox = widget.pinKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final pinPosition = renderBox.localToGlobal(Offset.zero);
      final pinSize = renderBox.size;
      
      // Determine if touch is on top or bottom part of image
      // Use 40% threshold - if touch is in bottom 40%, it's a bottom touch
      final touchYRelative = widget.touchPoint.dy - pinPosition.dy;
      final pinHeight = pinSize.height;
      
      _isBottomTouch = touchYRelative > (pinHeight * 0.6); // Bottom 40%
      _isTopTouch = touchYRelative < (pinHeight * 0.4); // Top 40%
    }
  }

  void _setupBackButtonListener() {
    // Back button handling is done via PopScope
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSaveTapped() {
    if (widget.onSaveWithTouchPoint != null) {
      widget.onSaveWithTouchPoint!(widget.touchPoint);
    } else {
      widget.onSave();
    }
  }

  /// Get list of actions based on context
  List<_QuickAction> _getActions() {
    switch (widget.actionContext) {
      case PinQuickActionContext.homeFeed:
        return [
          _QuickAction(
            icon: LucideIcons.pin,
            label: 'Save',
            displayLabel: 'Save',
            onTap: _onSaveTapped,
            isFunctional: true,
            isWhatsApp: false,
          ),
          _QuickAction(
            icon: LucideIcons.share2,
            label: 'Share',
            displayLabel: 'Share',
            onTap: widget.onShare ?? () {},
            isFunctional: false,
            isWhatsApp: false,
          ),
          _QuickAction(
            icon: LucideIcons.send,
            label: 'Send',
            displayLabel: 'Send with WhatsApp',
            onTap: widget.onSend ?? () {},
            isFunctional: false,
            isWhatsApp: true,
          ),
        ];
      case PinQuickActionContext.savedPins:
      case PinQuickActionContext.boardSection:
        return [
          _QuickAction(
            icon: LucideIcons.pin,
            label: 'Save',
            displayLabel: 'Save',
            onTap: _onSaveTapped,
            isFunctional: true,
            isWhatsApp: false,
          ),
          _QuickAction(
            icon: LucideIcons.pencil,
            label: 'Edit',
            displayLabel: 'Edit',
            onTap: widget.onEdit ?? () {},
            isFunctional: false,
            isWhatsApp: false,
          ),
          _QuickAction(
            icon: LucideIcons.share2,
            label: 'Share',
            displayLabel: 'Share',
            onTap: widget.onShare ?? () {},
            isFunctional: false,
            isWhatsApp: false,
          ),
          _QuickAction(
            icon: LucideIcons.send,
            label: 'Send',
            displayLabel: 'Send with WhatsApp',
            onTap: widget.onSend ?? () {},
            isFunctional: false,
            isWhatsApp: true,
          ),
        ];
    }
  }

  String _getCurrentLabel() {
    final actions = _getActions();
    if (_focusedButtonIndex != null && _focusedButtonIndex! < actions.length) {
      return actions[_focusedButtonIndex!].displayLabel;
    }
    // Default to first action when no button is focused
    return actions.isNotEmpty ? actions[0].displayLabel : '';
  }

  /// Calculate button positions in a circular arc pattern emanating from touch point
  List<Offset> _calculateButtonPositions(Size screenSize) {
    // Use the touch point as the origin for the circular arc
    final touchPoint = widget.touchPoint;
    final actions = _getActions();
    
    return _generateCircularArcPositions(touchPoint, actions.length, screenSize);
  }

  /// Calculate unified gap/spacing based on touch point position
  /// Returns the consistent gap value (24px) used across all positions
  /// This ensures the same spacing logic applies to left, mid, and right positions
  double _calculateUnifiedGap() {
    // Unified gap constant: 24px spacing used consistently across all positions
    // This matches the gap used on left side of images for the Save text
    // Applied uniformly to maintain consistent visual spacing
    const double baseGap = 24.0;
    return baseGap;
  }

  /// Calculate arc angles based on touch point position relative to screen
  /// Unified mathematical approach for all positions (left, mid, right)
  /// Returns start and end angles for the icon arc distribution
  ({double startAngle, double endAngle}) _calculateArcAngles(
    Offset center,
    Size screenSize,
  ) {
    // 40 degrees counterclockwise offset in radians (base rotation)
    const double rotationOffset = -40 * math.pi / 180; // -0.698 radians
    
    // Normalize touch point position (0.0 = leftmost, 1.0 = rightmost)
    final normalizedX = (center.dx / screenSize.width).clamp(0.0, 1.0);
    
    // Calculate available space on both sides
    final spaceOnLeft = center.dx;
    final spaceOnRight = screenSize.width - center.dx;
    final minSpace = math.min(spaceOnLeft, spaceOnRight);
    
    // Determine if we have enough space (threshold: 200px)
    final hasEnoughSpace = minSpace > 200;
    
    // Base arc angles - unified calculation based on normalized position
    // Arc spreads AWAY from screen edges to prevent clipping
    double startAngle, endAngle;
    
    if (normalizedX < 0.4) {
      // Left side of screen (0-40%): icons spread to the RIGHT
      if (hasEnoughSpace) {
        // Tighter arc when there's enough space
        startAngle = -0.698; // -40 degrees (top-right)
        endAngle = 0.524;    // 30 degrees (bottom-right)
      } else {
        // Wider arc when space is limited
        startAngle = -0.873; // -50 degrees (top-right)
        endAngle = 0.873;    // 50 degrees (bottom-right)
      }
    } else if (normalizedX > 0.6) {
      // Right side of screen (60-100%): icons spread to the LEFT
      // Proper curve centered on touch point: smooth arc from up-left to down-left
      if (hasEnoughSpace) {
        // Tighter arc when there's enough space: 90° arc centered on left (180°)
        // From 135° (up-left) to 225° (down-left) = 3π/4 to 5π/4
        startAngle = 3 * math.pi / 4;  // 135 degrees (up-left)
        endAngle = 5 * math.pi / 4;     // 225 degrees (down-left)
      } else {
        // Wider arc when space is limited: 120° arc
        // From 120° (up-left) to 240° (down-left) = 2π/3 to 4π/3
        startAngle = 2 * math.pi / 3;  // 120 degrees (up-left)
        endAngle = 4 * math.pi / 3;    // 240 degrees (down-left)
      }
    } else {
      // Mid screen (40-60%): balanced spread
      // Use intermediate angles for centered positioning
      if (hasEnoughSpace) {
        startAngle = -1.396; // -80 degrees (top)
        endAngle = 1.396;    // 80 degrees (bottom)
      } else {
        startAngle = -1.571; // -90 degrees (top)
        endAngle = 1.571;    // 90 degrees (bottom)
      }
    }
    
    // Adjust arc based on vertical touch position (top/bottom) for better UX
    if (_isBottomTouch) {
      // Bottom touch: extend arc downward
      if (normalizedX < 0.4) {
        // Left side bottom touch
        if (hasEnoughSpace) {
          startAngle = -0.698; // -40 degrees
          endAngle = 0.873;     // 50 degrees
        } else {
          startAngle = -0.873; // -50 degrees
          endAngle = 1.222;    // 70 degrees
        }
      } else if (normalizedX > 0.6) {
        // Right side bottom touch: curve extends more downward
        if (hasEnoughSpace) {
          // Arc from up-left to down-left, biased downward
          startAngle = 3 * math.pi / 4;  // 135 degrees (up-left)
          endAngle = 5 * math.pi / 4 + 0.35; // ~245 degrees (more down-left)
        } else {
          // Wider arc, more downward bias
          startAngle = 2 * math.pi / 3;  // 120 degrees (up-left)
          endAngle = 4 * math.pi / 3 + 0.52; // ~252 degrees (more down-left)
        }
      } else {
        // Mid bottom touch
        if (hasEnoughSpace) {
          startAngle = -1.396; // -80 degrees
          endAngle = 1.745;    // 100 degrees
        } else {
          startAngle = -1.571; // -90 degrees
          endAngle = 1.919;    // 110 degrees
        }
      }
    } else if (_isTopTouch) {
      // Top touch: bias arc downward
      if (normalizedX < 0.4) {
        // Left side top touch
        if (hasEnoughSpace) {
          startAngle = -0.524; // -30 degrees
          endAngle = 0.873;     // 50 degrees
        } else {
          startAngle = -0.524; // -30 degrees
          endAngle = 1.047;    // 60 degrees
        }
      } else if (normalizedX > 0.6) {
        // Right side top touch: curve extends more upward
        if (hasEnoughSpace) {
          // Arc from up-left to down-left, biased upward
          startAngle = 3 * math.pi / 4 - 0.35; // ~103 degrees (more up-left)
          endAngle = 5 * math.pi / 4;          // 225 degrees (down-left)
        } else {
          // Wider arc, more upward bias
          startAngle = 2 * math.pi / 3 - 0.52; // ~108 degrees (more up-left)
          endAngle = 4 * math.pi / 3;          // 240 degrees (down-left)
        }
      } else {
        // Mid top touch
        if (hasEnoughSpace) {
          startAngle = -1.222; // -70 degrees
          endAngle = 1.396;    // 80 degrees
        } else {
          startAngle = -1.396; // -80 degrees
          endAngle = 1.571;    // 90 degrees
        }
      }
    }
    
    // Apply 40-degree counterclockwise rotation to all angles
    startAngle += rotationOffset;
    endAngle += rotationOffset;
    
    return (startAngle: startAngle, endAngle: endAngle);
  }

  /// Generate positions on a true circular circumference around touch point
  /// Unified Pinterest-style positioning for all screen positions:
  /// - Icons spread AWAY from screen edges to prevent clipping
  /// - All icons shifted 40 degrees counterclockwise
  /// - Consistent gap/spacing (24px) applied uniformly
  /// - Mathematical approach ensures same logic for left, mid, and right positions
  List<Offset> _generateCircularArcPositions(Offset center, int count, Size screenSize) {
    if (count == 0) return [];
    
    // 40 degrees counterclockwise offset in radians
    const double rotationOffset = -40 * math.pi / 180; // -0.698 radians
    
    // Get unified gap value
    final gap = _calculateUnifiedGap();
    
    if (count == 1) {
      // Single button positioned based on normalized touch point position
      final normalizedX = (center.dx / screenSize.width).clamp(0.0, 1.0);
      double baseAngle;
      
      if (normalizedX < 0.4) {
        // Left side: spread right
        baseAngle = 0.0;
      } else if (normalizedX > 0.6) {
        // Right side: spread left
        baseAngle = math.pi;
      } else {
        // Mid: balanced
        baseAngle = math.pi / 2;
      }
      
      var rotatedAngle = baseAngle + rotationOffset;
      
      // Apply clockwise rotation for right-side images (shift toward top)
      if (normalizedX > 0.6) {
        const double clockwiseRotation = 90 * math.pi / 180; // 90 degrees clockwise
        rotatedAngle += clockwiseRotation; // Add for clockwise rotation
      }
      
      const radius = 90.0;
      const buttonSize = 48.0;
      
      return [
        Offset(
          center.dx + radius * math.cos(rotatedAngle) - (buttonSize / 2),
          center.dy + radius * math.sin(rotatedAngle) - (buttonSize / 2),
        )
      ];
    }
    
    const buttonSize = 48.0;
    const radius = 95.0; // Consistent radius for all positions
    
    // Fixed gap between icon centers (button size + gap spacing)
    // This ensures consistent linear spacing between icons, same as left side
    const fixedGapBetweenIcons = 72.0; // 48px button + 24px gap
    
    // Calculate arc angles using unified logic
    final arcAngles = _calculateArcAngles(center, screenSize);
    double startAngle = arcAngles.startAngle;
    double endAngle = arcAngles.endAngle;
    
    final angleRange = endAngle - startAngle;
    // Handle wrap-around case
    final normalizedRange = angleRange < 0 ? angleRange + (2 * math.pi) : angleRange;
    
    final positions = <Offset>[];
    
    // Calculate fixed angular spacing to achieve consistent linear gap
    // For a circle: angle = 2 * arcsin(gap / (2 * radius))
    // This ensures fixed linear distance between icon centers
    final fixedAngleIncrement = 2 * math.asin(fixedGapBetweenIcons / (2 * radius));
    
    // Calculate total arc length needed for all icons with fixed gap
    final totalArcLength = (count - 1) * fixedAngleIncrement;
    
    // Check if we have enough arc range, otherwise use proportional spacing
    final useFixedGap = totalArcLength <= normalizedRange;
    
    // Check if this is a right-side image for clockwise rotation
    final normalizedX = (center.dx / screenSize.width).clamp(0.0, 1.0);
    final isRightSide = normalizedX > 0.6;
    
    // Clockwise rotation offset for right-side images (toward top)
    // Shifts all icons clockwise starting from WhatsApp icon position
    const double clockwiseRotation = 57 * math.pi / 180; // 57 degrees clockwise
    
    final angles = <double>[];
    if (useFixedGap && count > 1) {
      // Use fixed gap spacing: center the icons within the available arc
      final usedArcLength = totalArcLength;
      final arcOffset = (normalizedRange - usedArcLength) / 2;
      
      for (int i = 0; i < count; i++) {
        var angle = startAngle + arcOffset + (i * fixedAngleIncrement);
        // Apply clockwise rotation for right-side images (shift toward top)
        if (isRightSide) {
          angle += clockwiseRotation; // Add for clockwise rotation
        }
        angles.add(angle);
      }
    } else {
      // Fallback to even angular distribution if fixed gap doesn't fit
      for (int i = 0; i < count; i++) {
        final t = count > 1 ? i / (count - 1) : 0.5;
        var angle = startAngle + (normalizedRange * t);
        // Apply clockwise rotation for right-side images (shift toward top)
        if (isRightSide) {
          angle += clockwiseRotation; // Add for clockwise rotation
        }
        angles.add(angle);
      }
    }
    
    // Now calculate positions from angles, ensuring even spacing
    for (int i = 0; i < count; i++) {
      final angle = angles[i];
      
      // Calculate position on circle circumference using trigonometry
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      
      // Adjust to center the button on the calculated point
      final buttonX = x - (buttonSize / 2);
      final buttonY = y - (buttonSize / 2);
      
      // Unified gap application: ensure buttons stay on screen with consistent padding
      // Same gap logic applied to all positions (left, mid, right)
      var finalX = buttonX;
      var finalY = buttonY;
      
      // Clamp X position with consistent gap (left and right)
      if (finalX < gap) {
        finalX = gap;
      } else if (finalX > screenSize.width - buttonSize - gap) {
        finalX = screenSize.width - buttonSize - gap;
      }
      
      // Clamp Y position with consistent gap (top and bottom)
      if (finalY < gap) {
        finalY = gap;
      } else if (finalY > screenSize.height - buttonSize - gap) {
        finalY = screenSize.height - buttonSize - gap;
      }
      
      positions.add(Offset(finalX, finalY));
    }
    
    return positions;
  }

  /// Find which button is selected based on 30-degree angular sectors (Pinterest style)
  /// Each icon occupies a 30-degree sector from the touch point
  int? _findClosestButtonIndex(Offset panPosition, List<Offset> buttonPositions) {
    if (buttonPositions.isEmpty) return null;
    
    // Get the touch point (center of the circle)
    final center = widget.touchPoint;
    
    // Calculate distance from center
    final distance = (panPosition - center).distance;
    
    // Must be within reasonable range
    const minRadius = 30.0; // Minimum distance from center
    const maxRadius = 150.0; // Maximum distance from center
    
    if (distance < minRadius || distance > maxRadius) {
      // Too close or too far from center
      return null;
    }
    
    // Calculate angle from center to pan position
    final dx = panPosition.dx - center.dx;
    final dy = panPosition.dy - center.dy;
    
    // Calculate angle in radians (-π to π)
    double angle = math.atan2(dy, dx);
    
    // Convert to 0-2π range
    if (angle < 0) {
      angle += 2 * math.pi;
    }
    
    // Convert to degrees (0-360)
    double angleDegrees = angle * 180 / math.pi;
    
    // Calculate angles for each button position
    final buttonAngles = <double>[];
    
    for (int i = 0; i < buttonPositions.length; i++) {
      final buttonCenter = Offset(
        buttonPositions[i].dx + 24.0, // buttonRadius
        buttonPositions[i].dy + 24.0,
      );
      
      final btnDx = buttonCenter.dx - center.dx;
      final btnDy = buttonCenter.dy - center.dy;
      
      double btnAngle = math.atan2(btnDy, btnDx);
      if (btnAngle < 0) {
        btnAngle += 2 * math.pi;
      }
      buttonAngles.add(btnAngle * 180 / math.pi);
    }
    
    // Find which button's 30-degree sector the pan position falls into
    // Each button occupies approximately 30 degrees (±15 degrees from center)
    int? selectedIndex;
    double minAngleDiff = double.infinity;
    
    for (int i = 0; i < buttonAngles.length; i++) {
      // Calculate angular difference
      double angleDiff = (angleDegrees - buttonAngles[i]).abs();
      
      // Handle wrap-around (e.g., 350° and 10°)
      if (angleDiff > 180) {
        angleDiff = 360 - angleDiff;
      }
      
      // Check if within 30-degree sector (15 degrees on each side)
      if (angleDiff <= 15.0 && angleDiff < minAngleDiff) {
        minAngleDiff = angleDiff;
        selectedIndex = i;
      }
    }
    
    return selectedIndex;
  }

  /// Handle pan update to track finger movement
  /// Pinterest-style: Immediate visual feedback as finger moves
  void _handlePanUpdate(DragUpdateDetails details) {
    if (_isDismissing) return;
    
    final screenSize = MediaQuery.of(context).size;
    final buttonPositions = _calculateButtonPositions(screenSize);
    final actions = _getActions();
    
    // Use current pan position for tracking
    final panPosition = details.globalPosition;
    
    // Find which button is in the 30-degree sector
    final closestIndex = _findClosestButtonIndex(panPosition, buttonPositions);
    
    // Update state immediately for responsive feedback
    if (mounted) {
      final newFocusedIndex = closestIndex != null && closestIndex < actions.length 
          ? closestIndex 
          : null;
      
      // Update pan position for rotation calculation
      final shouldUpdate = _focusedButtonIndex != newFocusedIndex || 
                          _currentPanPosition != panPosition;
      
      if (shouldUpdate) {
        setState(() {
          _focusedButtonIndex = newFocusedIndex;
          _currentPanPosition = panPosition;
          
          if (newFocusedIndex != null && newFocusedIndex < actions.length) {
            // Show moreHorizontal menu when Save is hovered
            final action = actions[newFocusedIndex];
            _showMoreHorizontal = action.label == 'Save';
          } else {
            _showMoreHorizontal = false;
          }
        });
      }
    }
  }

  /// Handle pan end - trigger action if over a button
  void _handlePanEnd(DragEndDetails details) {
    if (_isDismissing) return;
    
    final screenSize = MediaQuery.of(context).size;
    final buttonPositions = _calculateButtonPositions(screenSize);
    final actions = _getActions();
    
    // Check if pan ended over a button
    final panPosition = details.globalPosition;
    final closestIndex = _findClosestButtonIndex(panPosition, buttonPositions);
    
    if (closestIndex != null && closestIndex < actions.length) {
      // Trigger the action
      actions[closestIndex].onTap();
      _handleDismiss();
      return;
    }
    
    // If not over a button, clear focus after a delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && !_isDismissing) {
        setState(() {
          _focusedButtonIndex = null;
          _showMoreHorizontal = false;
          _currentPanPosition = null;
        });
      }
    });
  }
  
  /// Calculate text label position using unified gap logic
  /// Returns position configuration with left/right values
  /// Text positioned opposite to touch point side for optimal visibility
  ({double? left, double? right}) _calculateTextLabelPosition(Size screenSize) {
    final gap = _calculateUnifiedGap();
    final normalizedX = (widget.touchPoint.dx / screenSize.width).clamp(0.0, 1.0);
    
    // Position text opposite to touch point side
    // Left side (0-50%): text on right
    // Right side (50-100%): text on left
    // Mid (around 50%): prefer right side for consistency
    if (normalizedX < 0.5) {
      // Touch point on left/mid: text on right side
      return (left: null, right: gap);
    } else {
      // Touch point on right: text on left side
      return (left: gap, right: null);
    }
  }

  /// Calculate icon rotation based on touch point horizontal position on screen
  /// Unified logic for all positions (left, mid, right)
  /// Returns rotation in degrees (counterclockwise is negative)
  /// 
  /// Rotation calculation:
  /// - Leftmost side (x = 0): 0 degrees
  /// - Mid screen (x = screenWidth/2): -2.5 degrees counterclockwise
  /// - Rightmost side (x = screenWidth): -5 degrees counterclockwise
  /// 
  /// This creates a smooth rotation as user moves from left to right,
  /// matching Pinterest's behavior where icons rotate counterclockwise
  /// when positioned toward the right side or center of the screen.
  double _calculateIconRotation() {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    
    // Use the initial touch point position for rotation calculation
    // This ensures consistent rotation based on where the user initially touched
    final touchPointX = widget.touchPoint.dx;
    
    // Normalize touch point X position (0.0 = leftmost, 1.0 = rightmost)
    final normalizedX = touchPointX / screenWidth;
    
    // Clamp normalizedX to [0.0, 1.0] to handle edge cases
    final clampedX = normalizedX.clamp(0.0, 1.0);
    
    // Linear interpolation: 0 degrees at leftmost, -5 degrees at rightmost
    // Counterclockwise rotation (negative values)
    // Formula: rotation = -5.0 * normalizedX
    // This gives: 0° at left, -2.5° at mid, -5° at right
    final rotationDegrees = -5.0 * clampedX;
    
    return rotationDegrees;
  }

  void _handleDismiss() {
    if (_isDismissing) return;
    _isDismissing = true;
    
    _controller.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonPositions = _calculateButtonPositions(screenSize);
    final actions = _getActions();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop && !_isDismissing) {
          _handleDismiss();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onPanUpdate: _handlePanUpdate,
            onPanEnd: _handlePanEnd,
            onTap: _handleDismiss,
            behavior: HitTestBehavior.opaque, // Capture all gestures
            child: Stack(
              children: [
                // Background dimming layer - theme based
                Positioned.fill(
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withValues(alpha: _backgroundOpacity.value)
                        : Colors.black.withValues(alpha: _backgroundOpacity.value * 0.5),
                  ),
                ),

                // Touch point marker: hollow circle with black circumference
                Positioned(
                  left: widget.touchPoint.dx - 16,
                  top: widget.touchPoint.dy - 16,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: _overlayOpacity.value,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),

                // Individual action buttons positioned in arc pattern
                ...List.generate(actions.length, (index) {
                  if (index >= buttonPositions.length) return const SizedBox.shrink();
                  
                  final action = actions[index];
                  final position = buttonPositions[index];
                  final isFocused = _focusedButtonIndex == index;
                  final iconRotation = _calculateIconRotation();
                  
                  return Positioned(
                    left: position.dx,
                    top: position.dy,
                    child: Opacity(
                      opacity: _overlayOpacity.value,
                      child: Transform.scale(
                        scale: _overlayScale.value,
                        child: Transform.rotate(
                          angle: iconRotation * math.pi / 180, // Convert degrees to radians
                          child: RepaintBoundary(
                            child: _PinQuickActionButton(
                              icon: action.icon,
                              isFocused: isFocused,
                              isWhatsApp: action.isWhatsApp,
                              onTap: () {
                                if (_controller.status == AnimationStatus.completed) {
                                  action.onTap();
                                  // Dismiss overlay after any action
                                  _handleDismiss();
                                }
                              },
                              onFocusChanged: (focused) {
                                // This is handled by pan gesture now
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),

                // MoreHorizontal menu (three dots) - appears when Save is hovered
                if (_showMoreHorizontal && _focusedButtonIndex == 0 && buttonPositions.isNotEmpty)
                  Positioned(
                    left: buttonPositions[0].dx + 60, // Position to the right of Save button
                    top: buttonPositions[0].dy,
                    child: IgnorePointer(
                      ignoring: _controller.status != AnimationStatus.completed,
                      child: Opacity(
                        opacity: _overlayOpacity.value,
                        child: Transform.scale(
                          scale: _overlayScale.value,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.scale(
                                  scale: 0.8 + (0.2 * value),
                                  child: _MoreHorizontalButton(
                                    onTap: () {
                                      // Handle more options tap
                                      _handleDismiss();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                // Dynamic text label - positioned using unified gap logic
                // Text positioned opposite to touch point side for better visibility
                if (_getCurrentLabel().isNotEmpty && !_showMoreHorizontal)
                  Positioned(
                    left: _calculateTextLabelPosition(screenSize).left,
                    right: _calculateTextLabelPosition(screenSize).right,
                    top: _focusedButtonIndex != null && 
                         buttonPositions.isNotEmpty && 
                         _focusedButtonIndex! < buttonPositions.length
                        ? buttonPositions[_focusedButtonIndex!].dy - 12 // Align with focused button vertically
                        : buttonPositions.isNotEmpty
                            ? buttonPositions[0].dy - 12 // Align with first button by default
                            : screenSize.height / 2 - 20, // Center vertically if no buttons
                    child: IgnorePointer(
                      ignoring: true,
                      child: Opacity(
                        opacity: _overlayOpacity.value,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: Text(
                            _getCurrentLabel(),
                            key: ValueKey(_getCurrentLabel()),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.3,
                              decoration: TextDecoration.none,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                ),
                              ],
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
      ),
    );
  }
}

/// Individual action button
class _PinQuickActionButton extends StatefulWidget {
  const _PinQuickActionButton({
    required this.icon,
    required this.onTap,
    required this.isFocused,
    required this.isWhatsApp,
    required this.onFocusChanged,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isFocused;
  final bool isWhatsApp;
  final void Function(bool) onFocusChanged;

  @override
  State<_PinQuickActionButton> createState() => _PinQuickActionButtonState();
}

class _PinQuickActionButtonState extends State<_PinQuickActionButton> {
  static const double _buttonSize = 48.0;
  static const Color _whatsappGreen = Color(0xFF25D366);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isHoveredOrFocused = widget.isFocused;
    
    // Pinterest-style strict visual feedback:
    // - Focused: White background, black icon, larger size
    // - WhatsApp focused: Green background, white icon, larger size
    // - Unfocused: Dark grey background, white icon, normal size
    Color backgroundColor;
    Color iconColor;
    double buttonScale = 1.0;
    
    if (widget.isWhatsApp && isHoveredOrFocused) {
      // WhatsApp button: Green background when focused (Pinterest style)
      backgroundColor = _whatsappGreen;
      iconColor = Colors.white;
      buttonScale = 1.15; // More prominent when focused
    } else if (isHoveredOrFocused) {
      // Focused state: White background with black icon (Pinterest style)
      backgroundColor = Colors.white;
      iconColor = Colors.black87;
      buttonScale = 1.15; // More prominent when focused
    } else {
      // Default state: Dark grey background with white icon
      backgroundColor = isDark 
          ? const Color(0xFF2A2A2A)  // Consistent dark grey
          : const Color(0xFF4A4A4A); // Consistent grey for light theme
      iconColor = Colors.white;
      buttonScale = 1.0;
    }

    return GestureDetector(
      // Only handle taps, let pan gestures pass through to parent
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120), // Faster animation for responsiveness
        curve: Curves.easeOutCubic, // Smoother curve
        width: _buttonSize * buttonScale,
        height: _buttonSize * buttonScale,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: isHoveredOrFocused
              ? [
                  BoxShadow(
                    color: backgroundColor.withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  // Subtle shadow even when not focused for depth
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Icon(
          widget.icon,
          size: 22 * buttonScale,
          color: iconColor,
        ),
      ),
    );
  }
}

/// MoreHorizontal button (three dots menu)
class _MoreHorizontalButton extends StatelessWidget {
  const _MoreHorizontalButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  static const double _buttonSize = 48.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _buttonSize,
        height: _buttonSize,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          LucideIcons.moreHorizontal,
          size: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Quick action data class
class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.displayLabel,
    required this.onTap,
    required this.isFunctional,
    required this.isWhatsApp,
  });

  final IconData icon;
  final String label;
  final String displayLabel; // Text to show in the label
  final VoidCallback onTap;
  final bool isFunctional;
  final bool isWhatsApp; // Whether this is the WhatsApp/Send button
}
