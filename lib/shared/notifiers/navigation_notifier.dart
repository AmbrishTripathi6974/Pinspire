// Navigation StateNotifier with SharedPreferences persistence
// Manages tab navigation state with automatic persistence

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/shared/state/navigation_state.dart';

/// StateNotifier for navigation state
///
/// Features:
/// - Persists last selected tab to SharedPreferences
/// - Restores user's position on app restart
/// - Syncs with go_router navigation
/// - Tracks navigation history for back navigation
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier({
    required LocalStorageService localStorage,
  })  : _localStorage = localStorage,
        super(const NavigationState()) {
    _loadPersistedState();
  }

  final LocalStorageService _localStorage;

  /// Loads persisted state from SharedPreferences
  Future<void> _loadPersistedState() async {
    try {
      final tabIndex = _localStorage.getInt(StorageKeys.lastSelectedTab);

      if (tabIndex != null && tabIndex >= 0 && tabIndex < AppTab.values.length) {
        state = state.copyWith(
          selectedTab: AppTab.values[tabIndex],
          isInitialized: true,
        );
      } else {
        state = state.copyWith(isInitialized: true);
      }
    } catch (_) {
      // Use default state on error
      state = state.copyWith(isInitialized: true);
    }
  }

  /// Persists current tab to SharedPreferences
  Future<void> _persistState() async {
    try {
      await _localStorage.setInt(
        StorageKeys.lastSelectedTab,
        state.selectedTab.index,
      );
    } catch (_) {
      // Silently fail
    }
  }

  /// Selects a tab
  ///
  /// Updates state and persists to storage.
  /// Returns true if navigation occurred.
  Future<bool> selectTab(AppTab tab) async {
    if (state.selectedTab == tab) return false;

    state = state.copyWith(
      previousTab: state.selectedTab,
      selectedTab: tab,
      deepLinkPath: null,
    );

    await _persistState();
    return true;
  }

  /// Selects tab by index
  ///
  /// Used by bottom navigation bar.
  Future<bool> selectTabByIndex(int index) async {
    if (index < 0 || index >= AppTab.values.length) return false;
    return selectTab(AppTab.values[index]);
  }

  /// Selects tab by route path
  ///
  /// Used when syncing with go_router.
  Future<bool> selectTabByRoutePath(String path) async {
    final tab = AppTab.fromRoutePath(path);
    if (tab == null) return false;
    return selectTab(tab);
  }

  /// Goes back to previous tab
  ///
  /// Returns true if there was a previous tab to go back to.
  Future<bool> goBack() async {
    if (!state.canGoBack) return false;
    return selectTab(state.previousTab!);
  }

  /// Goes to home tab
  Future<void> goHome() async {
    await selectTab(AppTab.home);
  }

  /// Sets deep link path
  ///
  /// Used when app is opened via deep link.
  void setDeepLinkPath(String path) {
    state = state.copyWith(deepLinkPath: path);
  }

  /// Clears deep link path
  void clearDeepLinkPath() {
    state = state.copyWith(deepLinkPath: null);
  }

  /// Shows/hides bottom navigation
  void setBottomNavVisible(bool visible) {
    if (state.isBottomNavVisible == visible) return;
    state = state.copyWith(isBottomNavVisible: visible);
  }

  /// Toggles bottom navigation visibility
  void toggleBottomNav() {
    state = state.copyWith(isBottomNavVisible: !state.isBottomNavVisible);
  }

  /// Hides bottom navigation
  void hideBottomNav() => setBottomNavVisible(false);

  /// Shows bottom navigation
  void showBottomNav() => setBottomNavVisible(true);
}
