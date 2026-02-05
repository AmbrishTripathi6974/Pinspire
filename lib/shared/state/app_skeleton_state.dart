// App-level skeleton loading state
// Tracks visibility and when skeleton was shown for minimum display duration

/// State for the app skeleton overlay (cold start, resume, first login).
class AppSkeletonState {
  const AppSkeletonState({
    this.visible = false,
    this.shownAt,
  });

  final bool visible;
  final DateTime? shownAt;

  AppSkeletonState copyWith({bool? visible, DateTime? shownAt}) {
    return AppSkeletonState(
      visible: visible ?? this.visible,
      shownAt: shownAt ?? this.shownAt,
    );
  }

  /// Minimum duration the skeleton should stay visible (avoids flash).
  static const minDisplayDuration = Duration(milliseconds: 600);

  /// Remaining time to wait before it's safe to hide (0 if min duration already elapsed).
  Duration get remainingMinDisplay {
    if (!visible || shownAt == null) return Duration.zero;
    final elapsed = DateTime.now().difference(shownAt!);
    if (elapsed >= minDisplayDuration) return Duration.zero;
    return minDisplayDuration - elapsed;
  }
}
