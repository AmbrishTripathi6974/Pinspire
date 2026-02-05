// Route path constants for type-safe navigation
// Contains all route names and paths used throughout the app

/// Route path constants
///
/// Use these instead of hardcoded strings for type safety
/// and easy refactoring.
abstract class AppRoutes {
  // =========================================================================
  // Root Routes
  // =========================================================================

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // =========================================================================
  // Auth Routes
  // =========================================================================

  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String signUp = '/auth/signup';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyEmail = '/auth/verify-email';

  // =========================================================================
  // Main Tab Routes (Shell Routes)
  // =========================================================================

  /// Home feed tab
  static const String home = '/home';

  /// Search tab
  static const String search = '/search';

  /// Create/Add pin tab
  static const String create = '/create';

  /// Notifications tab
  static const String notifications = '/notifications';

  /// Profile tab
  static const String profile = '/profile';

  // =========================================================================
  // Nested Routes - Notifications (Inbox)
  // =========================================================================

  /// Inbox Messages list (See all)
  static const String inboxMessages = 'messages';
  static const String inboxMessagesPath = '/notifications/messages';

  /// Update topic page (title + grid of related pins)
  /// Standalone route at root to avoid shell branch matching issues.
  static const String topic = '/topic';
  static String topicPath(String title) {
    // Truncate and sanitize for URL (long/special chars can break routing)
    final safe = title.length > 80 ? '${title.substring(0, 80)}' : title;
    return '$topic?title=${Uri.encodeComponent(safe)}';
  }

  // =========================================================================
  // Nested Routes - Search
  // =========================================================================

  /// Search results
  static const String searchResults = 'results';
  static const String searchResultsPath = '/search/results';

  // =========================================================================
  // Nested Routes - Profile
  // =========================================================================

  /// User's saved pins
  static const String saved = 'saved';
  static const String savedPath = '/profile/saved';

  /// User's boards/collections
  static const String boards = 'boards';
  static const String boardsPath = '/profile/boards';

  /// Board detail
  static const String boardDetail = 'board/:boardId';
  static String boardDetailPath(String boardId) => '/profile/board/$boardId';

  /// Settings
  static const String settings = 'settings';
  static const String settingsPath = '/profile/settings';

  /// Edit profile
  static const String editProfile = 'edit';
  static const String editProfilePath = '/profile/edit';

  // =========================================================================
  // Standalone Routes (outside shell)
  // =========================================================================

  /// Full-screen pin viewer
  static const String pinViewer = '/pin/:pinId';
  static String pinViewerPath(String pinId, {String? heroTag}) {
    final path = '/pin/$pinId';
    if (heroTag != null) {
      return '$path?heroTag=${Uri.encodeComponent(heroTag)}';
    }
    return path;
  }

  /// Create new board
  static const String createBoard = '/create-board';

  /// Save pin to board (modal route)
  static const String savePinToBoard = '/save-to-board/:pinId';
  static String savePinToBoardPath(String pinId) => '/save-to-board/$pinId';

  // =========================================================================
  // Route Names (for named navigation)
  // =========================================================================

  static const String homeName = 'home';
  static const String searchName = 'search';
  static const String createName = 'create';
  static const String notificationsName = 'notifications';
  static const String profileName = 'profile';
  static const String boardDetailName = 'boardDetail';
  static const String settingsName = 'settings';
  static const String loginName = 'login';
  static const String signUpName = 'signUp';
}

/// Route parameter keys
abstract class RouteParams {
  static const String pinId = 'pinId';
  static const String boardId = 'boardId';
  static const String query = 'query';
  static const String userId = 'userId';
}

/// Route query parameter keys
abstract class RouteQueryParams {
  static const String tab = 'tab';
  static const String search = 'q';
  static const String filter = 'filter';
  static const String sort = 'sort';
}
