// Storage key constants for SharedPreferences
// Centralized keys to avoid typos and enable easy refactoring

/// Storage keys for persisted app state
abstract class StorageKeys {
  // Saved pins state
  static const String savedPins = 'saved_pins';
  static const String likedPins = 'liked_pins';
  static const String savedPinsCache = 'saved_pins_cache';

  // Collections/boards state
  static const String collections = 'collections';
  static const String collectionsCache = 'collections_cache';
  static const String lastSelectedBoardId = 'last_selected_board_id';

  // Navigation state
  static const String lastSelectedTab = 'last_selected_tab';

  // Auth UI state (not session - that's handled by Clerk)
  static const String isLoggedIn = 'is_logged_in';
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String lastAuthScreen = 'last_auth_screen';
  static const String rememberEmail = 'remember_email';
  static const String savedEmail = 'saved_email';

  // Post-login onboarding state
  static const String hasCompletedPostLoginOnboarding = 'has_completed_post_login_onboarding';
  static const String onboardingCurrentStep = 'onboarding_current_step';
  static const String onboardingGender = 'onboarding_gender';
  static const String onboardingCountry = 'onboarding_country';
  static const String onboardingInterests = 'onboarding_interests';

  // App preferences
  static const String themeMode = 'theme_mode';
  static const String gridColumns = 'grid_columns';

  // Home feed cache
  static const String feedCache = 'feed_cache';
  static const String feedCacheTimestamp = 'feed_cache_timestamp';

  // Search / Discover cache (reduces refetch when switching to search tab)
  static const String discoverCache = 'discover_cache';
  static const String trendingSearchCache = 'trending_search_cache';

  // Inbox / Updates (read and hidden update IDs)
  static const String inboxReadUpdateIds = 'inbox_read_update_ids';
  static const String inboxHiddenUpdateIds = 'inbox_hidden_update_ids';

  // Inbox updates cache (instant load when opening Inbox)
  static const String inboxUpdatesCache = 'inbox_updates_cache';
}
