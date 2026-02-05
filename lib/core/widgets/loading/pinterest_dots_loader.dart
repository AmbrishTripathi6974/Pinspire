// Pinterest-style three-dots loading: dots rotate in a circle; gradient cycles each rotation.

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Pinterest-style loading: three dots on a circular path, rotating around the center.
/// After every complete rotation, dot colors shift through a gradient (Pinterest brand–style).
///
/// Use [PinterestDotsLoader] for full-page/refresh; [PinterestDotsLoader.compact] for
/// buttons and inline loading. Use [PinterestDotsLoader.centered] for drop-in replacement
/// of Center(child: CircularProgressIndicator()).
class PinterestDotsLoader extends StatefulWidget {
  const PinterestDotsLoader({
    super.key,
    this.size = 40.0,
    this.dotSize = 8.0,
    this.radiusFactor = 0.5,
  });

  /// Compact variant for buttons, list items, and inline loading (same design, smaller).
  const PinterestDotsLoader.compact({
    super.key,
    this.radiusFactor = 0.5,
  })  : size = 24.0,
        dotSize = 5.0;

  /// Overall size of the circular loader (circle diameter).
  final double size;

  /// Diameter of each dot.
  final double dotSize;

  /// Radius of the circle as a fraction of [size] (0 to 1). Default 0.5 = half of size.
  final double radiusFactor;

  /// Centered full-page/refresh loading (drop-in for Center(child: CircularProgressIndicator())).
  static Widget centered({bool compact = false}) => Center(
        child: compact
            ? const PinterestDotsLoader.compact()
            : const PinterestDotsLoader(),
      );

  @override
  State<PinterestDotsLoader> createState() => _PinterestDotsLoaderState();
}

class _PinterestDotsLoaderState extends State<PinterestDotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotation;

  /// One full rotation duration (same as Pinterest feel).
  static const _rotationDuration = Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: _rotationDuration,
    )..repeat();

    _rotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  /// Gradient colors that cycle after each full rotation (Pinterest-like: red, warm gray, accent).
  static List<Color> _gradientColors(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      return [
        const Color(0xFFE60023), // Pinterest red
        const Color(0xFFB8A99A), // warm gray
        const Color(0xFFD4A574), // warm accent
        const Color(0xFFE60023),
      ];
    }
    return [
      const Color(0xFFE60023), // Pinterest red
      const Color(0xFF8B7355), // brown
      const Color(0xFFBD8B5A), // lighter brown
      const Color(0xFFE60023),
    ];
  }

  /// Current color for the gradient cycle (one full rotation = one cycle through colors).
  Color _colorAtRotation(double rotation, int dotIndex) {
    final colors = _gradientColors(context);
    // Stagger each dot's color by 1/3 so they're not all the same
    final t = (rotation + dotIndex / 3) % 1.0;
    final segment = (t * (colors.length - 1)).clamp(0.0, (colors.length - 1).toDouble());
    final i = segment.floor().clamp(0, colors.length - 2);
    final blend = segment - i;
    return Color.lerp(colors[i], colors[i + 1], blend)!;
  }

  @override
  Widget build(BuildContext context) {
    final radius = (widget.size * widget.radiusFactor) / 2;
    const dotCount = 3;
    const angleStep = 2 * math.pi / dotCount;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _rotation,
        builder: (context, child) {
          final angle = _rotation.value * 2 * math.pi;
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _CircleDotsPainter(
              radius: radius,
              dotSize: widget.dotSize,
              angleOffset: angle,
              dotCount: dotCount,
              angleStep: angleStep,
              colorAt: (dotIndex) => _colorAtRotation(_rotation.value, dotIndex),
            ),
          );
        },
      ),
    );
  }
}

class _CircleDotsPainter extends CustomPainter {
  _CircleDotsPainter({
    required this.radius,
    required this.dotSize,
    required this.angleOffset,
    required this.dotCount,
    required this.angleStep,
    required this.colorAt,
  });

  final double radius;
  final double dotSize;
  final double angleOffset;
  final int dotCount;
  final double angleStep;
  final Color Function(int dotIndex) colorAt;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (var i = 0; i < dotCount; i++) {
      final angle = angleOffset + i * angleStep;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      final paint = Paint()
        ..color = colorAt(i)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircleDotsPainter oldDelegate) {
    return oldDelegate.angleOffset != angleOffset ||
        oldDelegate.radius != radius ||
        oldDelegate.dotSize != dotSize;
  }
}
