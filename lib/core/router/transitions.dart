// Page transition animations for go_router
// Smooth, native-feeling transitions

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom page transitions for the app
abstract class AppTransitions {
  /// Default page transition duration
  static const Duration defaultDuration = Duration(milliseconds: 300);

  /// Fast transition duration
  static const Duration fastDuration = Duration(milliseconds: 200);

  /// Slow transition duration
  static const Duration slowDuration = Duration(milliseconds: 400);

  // =========================================================================
  // Slide Transitions
  // =========================================================================

  /// Slide from right (default push transition)
  static CustomTransitionPage<T> slideFromRight<T>({
    required LocalKey key,
    required Widget child,
    Duration? duration,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration ?? defaultDuration,
      reverseTransitionDuration: duration ?? defaultDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          )),
          child: child,
        );
      },
    );
  }

  /// Slide from bottom (for modals)
  static CustomTransitionPage<T> slideFromBottom<T>({
    required LocalKey key,
    required Widget child,
    Duration? duration,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration ?? defaultDuration,
      reverseTransitionDuration: duration ?? defaultDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          )),
          child: child,
        );
      },
    );
  }

  // =========================================================================
  // Fade Transitions
  // =========================================================================

  /// Simple fade transition
  static CustomTransitionPage<T> fade<T>({
    required LocalKey key,
    required Widget child,
    Duration? duration,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration ?? fastDuration,
      reverseTransitionDuration: duration ?? fastDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  /// Fade through transition (Material 3 style)
  static CustomTransitionPage<T> fadeThrough<T>({
    required LocalKey key,
    required Widget child,
    Duration? duration,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration ?? defaultDuration,
      reverseTransitionDuration: duration ?? defaultDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }

  // =========================================================================
  // Scale Transitions
  // =========================================================================

  /// Scale fade transition (for pin detail)
  static CustomTransitionPage<T> scaleFade<T>({
    required LocalKey key,
    required Widget child,
    Duration? duration,
    Alignment alignment = Alignment.center,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration ?? defaultDuration,
      reverseTransitionDuration: duration ?? defaultDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(curvedAnimation),
            alignment: alignment,
            child: child,
          ),
        );
      },
    );
  }

  // =========================================================================
  // No Transition (instant)
  // =========================================================================

  /// No transition (instant switch)
  static CustomTransitionPage<T> none<T>({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

/// Material 3 fade through transition
class FadeThroughTransition extends StatelessWidget {
  const FadeThroughTransition({
    super.key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([animation, secondaryAnimation]),
      builder: (context, _) {
        // Fade out the old page
        if (secondaryAnimation.value > 0) {
          return FadeTransition(
            opacity: ReverseAnimation(CurvedAnimation(
              parent: secondaryAnimation,
              curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
            )),
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.92).animate(
                CurvedAnimation(
                  parent: secondaryAnimation,
                  curve: Curves.easeOut,
                ),
              ),
              child: child,
            ),
          );
        }

        // Fade in the new page
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
              ),
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

/// Shared axis transition (horizontal)
class SharedAxisTransition extends StatelessWidget {
  const SharedAxisTransition({
    super.key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
    this.fillColor,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = fillColor ?? theme.colorScheme.surface;

    return AnimatedBuilder(
      animation: Listenable.merge([animation, secondaryAnimation]),
      builder: (context, _) {
        final isEntering = animation.status == AnimationStatus.forward ||
            animation.status == AnimationStatus.completed;

        final slideOffset = isEntering
            ? Tween<Offset>(
                begin: const Offset(0.1, 0.0),
                end: Offset.zero,
              ).evaluate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ))
            : Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(-0.1, 0.0),
              ).evaluate(CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.easeInCubic,
              ));

        final opacity = isEntering
            ? CurvedAnimation(
                parent: animation,
                curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
              ).value
            : CurvedAnimation(
                parent: ReverseAnimation(secondaryAnimation),
                curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
              ).value;

        return Container(
          color: backgroundColor,
          child: FadeTransition(
            opacity: AlwaysStoppedAnimation(opacity),
            child: SlideTransition(
              position: AlwaysStoppedAnimation(slideOffset),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
