// GoRouter configuration with all app routes
// Defines navigation structure and route hierarchy

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/core/router/guards/auth_guard.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/router/scaffold_with_nav.dart';
import 'package:pinterest/core/router/transitions.dart';
import 'package:pinterest/features/auth/domain/entities/user.dart';
import 'package:pinterest/features/auth/presentation/providers/auth_provider.dart';
import 'package:pinterest/shared/state/navigation_state.dart';

// Import page widgets
import 'package:pinterest/features/home/presentation/pages/home_feed_page.dart';
import 'package:pinterest/features/inbox/presentation/pages/inbox_page.dart';
import 'package:pinterest/features/inbox/presentation/pages/messages_page.dart';
import 'package:pinterest/features/inbox/presentation/pages/topic_pins_page.dart';
import 'package:pinterest/features/search/presentation/pages/search_page.dart';
import 'package:pinterest/features/search/presentation/pages/search_results_page.dart';
import 'package:pinterest/features/auth/presentation/pages/login_page.dart';
import 'package:pinterest/features/auth/presentation/pages/register_page.dart';
import 'package:pinterest/features/profile/presentation/pages/account_page.dart';
import 'package:pinterest/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:pinterest/features/profile/presentation/pages/saved_pins_page.dart';
import 'package:pinterest/features/profile/presentation/pages/saved_section_page.dart';
import 'package:pinterest/features/pin/presentation/pages/create_pin_page.dart';
import 'package:pinterest/features/pin/presentation/pages/pin_viewer_page.dart';
import 'package:pinterest/features/pin/presentation/pages/save_to_board_page.dart';
import 'package:pinterest/features/board/presentation/pages/board_detail_page.dart';
import 'package:pinterest/features/board/presentation/pages/boards_page.dart';
import 'package:pinterest/features/board/presentation/pages/create_board_page.dart';

/// Global navigator keys for independent navigation stacks
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'search');
final _createNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'create');
final _notificationsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'notifications');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

/// One-time initial tab index for GoRouter (e.g. from SharedPreferences).
/// Override from main() so the router is built once with the correct initial
/// location. Must NOT watch navigationProvider here — that would recreate
/// the router on every tab tap and cause flicker/rebuilds.
final initialTabIndexProvider = Provider<int?>((ref) => null);

/// One-time initial logged in flag from local storage.
/// Override from main() to allow immediate navigation to home feed
/// without waiting for Clerk auth check.
final isLoggedInFlagProvider = Provider<bool>((ref) => false);

/// Listenable that notifies when auth state changes so GoRouter re-evaluates redirect.
final authRefreshListenableProvider = Provider<ValueNotifier<int>>((ref) {
  final notifier = ValueNotifier(0);
  ref.listen<User?>(authStateProvider, (_, __) {
    notifier.value++;
  });
  return notifier;
});

/// Riverpod provider for the GoRouter instance
///
/// Built once; does NOT watch navigation state. Tab switching uses
/// StatefulNavigationShell.goBranch() only — no router rebuild.
final routerProvider = Provider<GoRouter>((ref) {
  final initialTabIndex = ref.read(initialTabIndexProvider);
  // Check auth state to ensure authenticated users don't start at auth routes
  final isAuthenticated = ref.read(isAuthenticatedProvider);
  final initialLocation = _getInitialLocationFromIndex(
    initialTabIndex,
    isAuthenticated: isAuthenticated,
  );
  final refreshListenable = ref.read(authRefreshListenableProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    refreshListenable: refreshListenable,

    // Redirect logic for auth and deep linking
    redirect: (context, state) => authRedirect(ref, state),

    routes: [
      // =====================================================================
      // Auth Routes (outside shell)
      // =====================================================================
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        pageBuilder: (context, state) => AppTransitions.slideFromBottom(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: AppRoutes.signUpName,
        pageBuilder: (context, state) => AppTransitions.slideFromBottom(
          key: state.pageKey,
          child: const RegisterPage(),
        ),
      ),

      // =====================================================================
      // Main App Shell (with bottom navigation)
      // =====================================================================
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNav(navigationShell: navigationShell);
        },
        branches: [
          // -------------------------------------------------------------------
          // Home Branch
          // -------------------------------------------------------------------
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.homeName,
                pageBuilder: (context, state) => AppTransitions.none(
                  key: state.pageKey,
                  child: const HomeFeedPage(),
                ),
              ),
            ],
          ),

          // -------------------------------------------------------------------
          // Search Branch
          // -------------------------------------------------------------------
          StatefulShellBranch(
            navigatorKey: _searchNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.search,
                name: AppRoutes.searchName,
                pageBuilder: (context, state) => AppTransitions.none(
                  key: state.pageKey,
                  child: const SearchPage(),
                ),
                routes: [
                  // Search results
                  GoRoute(
                    path: AppRoutes.searchResults,
                    pageBuilder: (context, state) {
                      final query = state.uri.queryParameters[RouteQueryParams.search];
                      return AppTransitions.slideFromRight(
                        key: state.pageKey,
                        child: SearchResultsPage(query: query),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // -------------------------------------------------------------------
          // Create Branch
          // -------------------------------------------------------------------
          StatefulShellBranch(
            navigatorKey: _createNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.create,
                name: AppRoutes.createName,
                pageBuilder: (context, state) => AppTransitions.none(
                  key: state.pageKey,
                  child: const CreatePinPage(),
                ),
              ),
            ],
          ),

          // -------------------------------------------------------------------
          // Notifications Branch (Inbox / Updates from followed users)
          // -------------------------------------------------------------------
          StatefulShellBranch(
            navigatorKey: _notificationsNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.notifications,
                name: AppRoutes.notificationsName,
                pageBuilder: (context, state) => AppTransitions.none(
                  key: state.pageKey,
                  child: const InboxPage(),
                ),
                routes: [
                  GoRoute(
                    path: AppRoutes.inboxMessages,
                    pageBuilder: (context, state) =>
                        AppTransitions.slideFromRight(
                      key: state.pageKey,
                      child: const MessagesPage(),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // -------------------------------------------------------------------
          // Profile Branch
          // -------------------------------------------------------------------
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: AppRoutes.profileName,
                pageBuilder: (context, state) => AppTransitions.none(
                  key: state.pageKey,
                  child: const SavedSectionPage(),
                ),
                routes: [
                  // Saved pins
                  GoRoute(
                    path: AppRoutes.saved,
                    pageBuilder: (context, state) => AppTransitions.slideFromRight(
                      key: state.pageKey,
                      child: const SavedPinsPage(),
                    ),
                  ),
                  // Boards
                  GoRoute(
                    path: AppRoutes.boards,
                    pageBuilder: (context, state) => AppTransitions.slideFromRight(
                      key: state.pageKey,
                      child: const BoardsPage(),
                    ),
                  ),
                  // Board detail
                  GoRoute(
                    path: AppRoutes.boardDetail,
                    name: AppRoutes.boardDetailName,
                    pageBuilder: (context, state) {
                      final boardId = state.pathParameters[RouteParams.boardId]!;
                      return AppTransitions.slideFromRight(
                        key: state.pageKey,
                        child: BoardDetailPage(boardId: boardId),
                      );
                    },
                  ),
                  // Settings (Your account)
                  GoRoute(
                    path: AppRoutes.settings,
                    name: AppRoutes.settingsName,
                    pageBuilder: (context, state) => AppTransitions.slideFromRight(
                      key: state.pageKey,
                      child: const AccountPage(),
                    ),
                  ),
                  // Edit profile
                  GoRoute(
                    path: AppRoutes.editProfile,
                    pageBuilder: (context, state) => AppTransitions.slideFromRight(
                      key: state.pageKey,
                      child: const EditProfilePage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // =====================================================================
      // Standalone Routes (outside shell, full screen)
      // =====================================================================

      // Topic pins (title + grid) - root route for reliable matching
      GoRoute(
        path: AppRoutes.topic,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Updates';
          return AppTransitions.slideFromRight(
            key: state.pageKey,
            child: TopicPinsPage(title: title),
          );
        },
      ),

      // Full-screen pin viewer
      GoRoute(
        path: AppRoutes.pinViewer,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final pinId = state.pathParameters[RouteParams.pinId]!;
          final heroTag = state.uri.queryParameters['heroTag'];
          return AppTransitions.scaleFade(
            key: state.pageKey,
            child: PinViewerPage(
              pinId: pinId,
              sourceHeroTag: heroTag,
            ),
          );
        },
      ),

      // Create board modal
      GoRoute(
        path: AppRoutes.createBoard,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitions.slideFromBottom(
          key: state.pageKey,
          child: const CreateBoardPage(),
        ),
      ),

      // Save to board modal
      GoRoute(
        path: AppRoutes.savePinToBoard,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final pinId = state.pathParameters[RouteParams.pinId]!;
          return AppTransitions.slideFromBottom(
            key: state.pageKey,
            child: SaveToBoardPage(pinId: pinId),
          );
        },
      ),
    ],

    // Error page
    errorPageBuilder: (context, state) => AppTransitions.fade(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
  );
});

/// Resolves initial location from optional persisted tab index.
/// Used only when building the router once; avoids watching navigation state.
/// 
/// For authenticated users, always returns a valid app route (never auth routes).
/// For unauthenticated users, returns home (though AuthGate will handle showing login).
String _getInitialLocationFromIndex(int? tabIndex, {required bool isAuthenticated}) {
  // If authenticated, ensure we never start at an auth route
  if (isAuthenticated) {
    if (tabIndex != null && tabIndex >= 0 && tabIndex < AppTab.values.length) {
      return AppTab.values[tabIndex].routePath;
    }
    return AppRoutes.home;
  }
  
  // For unauthenticated, default to home (AuthGate will show login screen)
  return AppRoutes.home;
}

/// Error page widget
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorMessage = error?.toString() ?? 'The page you are looking for does not exist.';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.circleExclamation,
                  size: 48,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                // Use SelectableText for long error messages and wrap in Flexible/Expanded
                // Limit height to prevent overflow
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      errorMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
