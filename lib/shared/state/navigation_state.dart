// Navigation state with Freezed
// Immutable state for tab navigation

import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_state.freezed.dart';
part 'navigation_state.g.dart';

/// Available main tabs in the app
enum AppTab {
  home,
  search,
  create,
  notifications,
  profile;

  /// Get the route path for this tab
  String get routePath {
    switch (this) {
      case AppTab.home:
        return '/home';
      case AppTab.search:
        return '/search';
      case AppTab.create:
        return '/create';
      case AppTab.notifications:
        return '/notifications';
      case AppTab.profile:
        return '/profile';
    }
  }

  /// Get tab from route path
  static AppTab? fromRoutePath(String path) {
    if (path.startsWith('/home')) return AppTab.home;
    if (path.startsWith('/search')) return AppTab.search;
    if (path.startsWith('/create')) return AppTab.create;
    if (path.startsWith('/notifications')) return AppTab.notifications;
    if (path.startsWith('/profile')) return AppTab.profile;
    return null;
  }

  /// Get tab from index
  static AppTab fromIndex(int index) {
    if (index < 0 || index >= AppTab.values.length) return AppTab.home;
    return AppTab.values[index];
  }
}

/// Immutable state for navigation
@freezed
class NavigationState with _$NavigationState {
  const NavigationState._();

  const factory NavigationState({
    /// Currently selected tab
    @Default(AppTab.home) AppTab selectedTab,

    /// Previous tab for back navigation
    AppTab? previousTab,

    /// Whether bottom nav is visible
    @Default(true) bool isBottomNavVisible,

    /// Whether navigation state has been initialized
    @Default(false) bool isInitialized,

    /// Current deep link path (if navigated via deep link)
    String? deepLinkPath,
  }) = _NavigationState;

  factory NavigationState.fromJson(Map<String, dynamic> json) =>
      _$NavigationStateFromJson(json);

  /// Get tab index for bottom navigation
  int get selectedTabIndex => selectedTab.index;

  /// Get route path for current tab
  String get currentRoutePath => selectedTab.routePath;

  /// Check if currently on home tab
  bool get isOnHome => selectedTab == AppTab.home;

  /// Check if currently on search tab
  bool get isOnSearch => selectedTab == AppTab.search;

  /// Check if currently on create tab
  bool get isOnCreate => selectedTab == AppTab.create;

  /// Check if currently on notifications tab
  bool get isOnNotifications => selectedTab == AppTab.notifications;

  /// Check if currently on profile tab
  bool get isOnProfile => selectedTab == AppTab.profile;

  /// Check if there's a previous tab to go back to
  bool get canGoBack => previousTab != null && previousTab != selectedTab;
}
