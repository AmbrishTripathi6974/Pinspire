// Riverpod providers for app state
// Connects StateNotifiers with dependency injection

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/di/injection.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/storage/user_scoped_storage_service.dart';
import 'package:pinterest/features/auth/presentation/providers/auth_provider.dart';
import 'package:pinterest/features/board/domain/entities/board.dart';
import 'package:pinterest/features/home/presentation/providers/feed_provider.dart';
import 'package:pinterest/features/onboarding/presentation/providers/onboarding_notifier.dart';
import 'package:pinterest/features/onboarding/presentation/providers/onboarding_state.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/shared/notifiers/auth_ui_notifier.dart';
import 'package:pinterest/shared/notifiers/collections_notifier.dart';
import 'package:pinterest/shared/notifiers/navigation_notifier.dart';
import 'package:pinterest/shared/notifiers/saved_pins_notifier.dart';
import 'package:pinterest/shared/state/auth_ui_state.dart';
import 'package:pinterest/shared/state/collections_state.dart';
import 'package:pinterest/shared/state/navigation_state.dart';
import 'package:pinterest/shared/state/saved_pins_state.dart';

// Re-export entities and state for convenience when importing providers
export 'package:pinterest/features/board/domain/entities/board.dart';
export 'package:pinterest/features/onboarding/presentation/providers/onboarding_state.dart'
    show Gender, OnboardingStep;
export 'package:pinterest/features/pin/domain/entities/pin.dart';
export 'package:pinterest/shared/state/collections_state.dart' show BoardSummary;
export 'package:pinterest/shared/state/navigation_state.dart' show AppTab;
export 'package:pinterest/shared/state/saved_pins_state.dart' show PinSaveState;
export 'package:pinterest/shared/notifiers/app_skeleton_notifier.dart';
export 'package:pinterest/shared/state/app_skeleton_state.dart';

// =============================================================================
// Core Provider
// =============================================================================

/// Provider for LocalStorageService from get_it
///
/// This bridges get_it DI with Riverpod
final localStorageProvider = Provider<LocalStorageService>((ref) {
  return getIt<LocalStorageService>();
});

/// Provider for user-scoped storage service
///
/// Automatically scopes all storage operations to the current user ID.
/// When user changes (login/logout), data is automatically isolated.
final userScopedStorageProvider = Provider<LocalStorageService>((ref) {
  final baseStorage = ref.watch(localStorageProvider);
  final userId = ref.watch(currentUserIdProvider);
  
  return UserScopedStorageService(
    baseStorage: baseStorage,
    userId: userId ?? '',
  );
});

// =============================================================================
// Saved Pins Providers
// =============================================================================

/// StateNotifierProvider for saved/liked pins
///
/// Automatically persists state to SharedPreferences with user-scoping
/// Data is isolated per user account
final savedPinsProvider =
    StateNotifierProvider<SavedPinsNotifier, SavedPinsState>((ref) {
  return SavedPinsNotifier(
    localStorage: ref.watch(userScopedStorageProvider),
  );
});

/// Convenience provider to check if a specific pin is saved
final isPinSavedProvider = Provider.family<bool, String>((ref, pinId) {
  return ref.watch(savedPinsProvider.select((state) => state.isPinSaved(pinId)));
});

/// Convenience provider to check if a specific pin is liked
final isPinLikedProvider = Provider.family<bool, String>((ref, pinId) {
  return ref.watch(savedPinsProvider.select((state) => state.isPinLiked(pinId)));
});

/// Provider for pin save state (both saved and liked)
///
/// Use this for efficient grid item rebuilds - only rebuilds when
/// save/like state changes for this specific pin.
final pinSaveStateProvider =
    Provider.family<PinSaveState, String>((ref, pinId) {
  return ref.watch(
    savedPinsProvider.select((state) => state.getPinState(pinId)),
  );
});

/// Provider for saved pins count
final savedPinsCountProvider = Provider<int>((ref) {
  return ref.watch(savedPinsProvider.select((state) => state.savedCount));
});

/// Provider for liked pins count
final likedPinsCountProvider = Provider<int>((ref) {
  return ref.watch(savedPinsProvider.select((state) => state.likedCount));
});

/// Provider for list of saved pins
final savedPinsListProvider = Provider<List<Pin>>((ref) {
  return ref.watch(savedPinsProvider.select((state) => state.savedPins));
});

/// Provider for saved pins IDs set
final savedPinIdsProvider = Provider<Set<String>>((ref) {
  return ref.watch(savedPinsProvider.select((state) => state.savedPinIds));
});

/// Provider for liked pins IDs set
final likedPinIdsProvider = Provider<Set<String>>((ref) {
  return ref.watch(savedPinsProvider.select((state) => state.likedPinIds));
});

/// Provider to get a saved pin by ID
final savedPinByIdProvider = Provider.family<Pin?, String>((ref, pinId) {
  return ref.watch(
    savedPinsProvider.select((state) => state.getSavedPin(pinId)),
  );
});

/// Provider for saved pins initialization state
final savedPinsInitializedProvider = Provider<bool>((ref) {
  return ref.watch(savedPinsProvider.select((state) => state.isInitialized));
});

/// Provider for saved pins version (for efficient rebuilds)
final savedPinsVersionProvider = Provider<int>((ref) {
  return ref.watch(savedPinsProvider.select((state) => state.version));
});

/// Provider for pin ID -> source search query (for "Ideas for you" from saved pins)
final savedPinSourceQueriesProvider = Provider<Map<String, String>>((ref) {
  return ref.watch(
    savedPinsProvider.select((state) => state.savedPinSourceQueries),
  );
});

// =============================================================================
// Collections Providers
// =============================================================================

/// StateNotifierProvider for boards/collections
///
/// Automatically persists state to SharedPreferences
final collectionsProvider =
    StateNotifierProvider<CollectionsNotifier, CollectionsState>((ref) {
  return CollectionsNotifier(
    localStorage: ref.watch(userScopedStorageProvider),
  );
});

/// Provider for the currently selected board
final selectedBoardProvider = Provider<Board?>((ref) {
  return ref.watch(collectionsProvider.select((state) => state.selectedBoard));
});

/// Provider for all boards list (in display order)
final boardsListProvider = Provider<List<Board>>((ref) {
  return ref.watch(collectionsProvider.select((state) => state.boards));
});

/// Provider for recent boards
final recentBoardsProvider = Provider<List<Board>>((ref) {
  return ref.watch(collectionsProvider.select((state) => state.recentBoards));
});

/// Provider for board count
final boardCountProvider = Provider<int>((ref) {
  return ref.watch(collectionsProvider.select((state) => state.boardCount));
});

/// Provider to get a specific board by ID
final boardByIdProvider = Provider.family<Board?, String>((ref, boardId) {
  return ref.watch(
    collectionsProvider.select((state) => state.getBoardById(boardId)),
  );
});

/// Provider to get board summary (for efficient list rendering)
final boardSummaryProvider =
    Provider.family<BoardSummary?, String>((ref, boardId) {
  return ref.watch(
    collectionsProvider.select((state) => state.getBoardSummary(boardId)),
  );
});

/// Provider to check if a pin is in any board
final isPinInAnyBoardProvider = Provider.family<bool, String>((ref, pinId) {
  return ref.watch(
    collectionsProvider.select((state) => state.isPinInAnyBoard(pinId)),
  );
});

/// Provider to check if a pin is in a specific board
final isPinInBoardProvider =
    Provider.family<bool, ({String pinId, String boardId})>((ref, params) {
  return ref.watch(
    collectionsProvider.select(
      (state) => state.isPinInBoard(params.pinId, params.boardId),
    ),
  );
});

/// Provider to get all boards containing a pin
final boardsContainingPinProvider =
    Provider.family<List<Board>, String>((ref, pinId) {
  return ref.watch(
    collectionsProvider.select((state) => state.getBoardsContainingPin(pinId)),
  );
});

/// Provider for collections initialization state
final collectionsInitializedProvider = Provider<bool>((ref) {
  return ref.watch(collectionsProvider.select((state) => state.isInitialized));
});

/// Provider for collections version (for efficient rebuilds)
final collectionsVersionProvider = Provider<int>((ref) {
  return ref.watch(collectionsProvider.select((state) => state.version));
});

/// Provider for public boards only
final publicBoardsProvider = Provider<List<Board>>((ref) {
  return ref.watch(collectionsProvider.select((state) => state.publicBoards));
});

/// Provider for private boards only
final privateBoardsProvider = Provider<List<Board>>((ref) {
  return ref.watch(collectionsProvider.select((state) => state.privateBoards));
});

// =============================================================================
// Navigation Providers
// =============================================================================

/// StateNotifierProvider for navigation state
///
/// Persists last selected tab for app resume
final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier(
    localStorage: ref.watch(userScopedStorageProvider),
  );
});

/// Provider for currently selected tab
final selectedTabProvider = Provider<AppTab>((ref) {
  return ref.watch(navigationProvider.select((state) => state.selectedTab));
});

/// Provider for selected tab index (for BottomNavigationBar)
final selectedTabIndexProvider = Provider<int>((ref) {
  return ref.watch(navigationProvider.select((state) => state.selectedTabIndex));
});

/// Provider for bottom nav visibility
final isBottomNavVisibleProvider = Provider<bool>((ref) {
  return ref.watch(
    navigationProvider.select((state) => state.isBottomNavVisible),
  );
});

// =============================================================================
// Auth UI Providers
// =============================================================================

/// StateNotifierProvider for auth UI state
///
/// Persists onboarding completion and email preferences
final authUiProvider =
    StateNotifierProvider<AuthUiNotifier, AuthUiState>((ref) {
  return AuthUiNotifier(
    localStorage: ref.watch(userScopedStorageProvider),
  );
});

/// Provider to check if onboarding should be shown
final shouldShowOnboardingProvider = Provider<bool>((ref) {
  return ref.watch(
    authUiProvider.select((state) => state.shouldShowOnboarding),
  );
});

/// Provider for saved email (for auto-fill)
final savedEmailProvider = Provider<String?>((ref) {
  return ref.watch(authUiProvider.select((state) => state.savedEmail));
});

/// Provider for remember email preference
final rememberEmailProvider = Provider<bool>((ref) {
  return ref.watch(authUiProvider.select((state) => state.rememberEmail));
});

/// Provider for auth form submitting state
final isAuthSubmittingProvider = Provider<bool>((ref) {
  return ref.watch(authUiProvider.select((state) => state.isSubmitting));
});

/// Provider for auth form errors
final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authUiProvider.select((state) => state.error));
});

// =============================================================================
// Post-Login Onboarding Providers
// =============================================================================

/// StateNotifierProvider for post-login onboarding flow
///
/// Manages onboarding state and persists to SharedPreferences
final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier(
    localStorage: ref.watch(userScopedStorageProvider),
  );
});

/// Provider to check if post-login onboarding has been completed
final hasCompletedOnboardingProvider = Provider<bool>((ref) {
  return ref.watch(onboardingProvider.select((state) => state.hasCompleted));
});

/// Provider for current onboarding step
final currentOnboardingStepProvider = Provider<OnboardingStep>((ref) {
  return ref.watch(onboardingProvider.select((state) => state.currentStep));
});

/// Provider for selected interests
final selectedInterestsProvider = Provider<Set<String>>((ref) {
  return ref.watch(onboardingProvider.select((state) => state.selectedInterests));
});

/// Provider to check if minimum interests are selected
final hasMinimumInterestsProvider = Provider<bool>((ref) {
  return ref.watch(
    onboardingProvider.select((state) => state.hasMinimumInterests),
  );
});

/// Provider for onboarding initialization state
final onboardingInitializedProvider = Provider<bool>((ref) {
  return ref.watch(onboardingProvider.select((state) => state.isInitialized));
});

// =============================================================================
// App Initialization Provider
// =============================================================================

/// Provider that tracks when the app is fully initialized and ready
///
/// For authenticated users: waits for auth resolved + onboarding initialized + feed loaded
/// For unauthenticated users: waits for auth resolved
///
/// Used to control when to remove the native splash screen.
final appInitializationProvider = Provider<bool>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  
  // For unauthenticated users, just wait for auth state to be resolved
  // (AuthGate handles this, so we can consider it ready once we know auth state)
  if (!isAuthenticated) {
    return true; // Auth state is resolved (user is not authenticated)
  }
  
  // For authenticated users, wait for:
  // 1. Onboarding state initialized
  final onboardingInitialized = ref.watch(onboardingInitializedProvider);
  if (!onboardingInitialized) {
    return false;
  }
  
  // 2. Onboarding completed (or skipped) - if still in onboarding, keep splash
  final onboardingState = ref.watch(onboardingProvider);
  if (!onboardingState.hasCompleted) {
    return false; // Still showing onboarding, keep splash
  }
  
  // 3. Feed has cached data available OR has finished initial loading
  // Pre-initialize feed provider early to start loading data before router navigates
  // This allows feed to start loading in parallel with router setup
  try {
    // Pre-initialize feed provider to start loading early
    // This will trigger feed initialization which loads cached data immediately
    final feedState = ref.watch(feedProvider);
    
    // If we have cached data (pins available), we can show UI immediately
    // Don't wait for fresh data to load - show cached data right away
    if (feedState.pins.isNotEmpty) {
      // We have cached data - remove splash immediately
      // Fresh data will load in background if cache is stale
      return true;
    }
    
    // If no cached data, wait for initial load to complete
    // But don't wait too long - set a reasonable timeout
    if (feedState.isInitialLoading) {
      return false;
    }
    
    // Feed has finished initial load (either loaded data or failed)
    return true;
  } catch (_) {
    // If there's an error accessing the provider, keep splash visible
    // This shouldn't happen in normal flow, but handle it gracefully
    return false;
  }
});
