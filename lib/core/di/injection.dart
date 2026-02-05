// GetIt service locator setup and initialization
// Configures all dependency injection for the application
//
// Registration Order (dependencies first):
// 1. External services (SharedPreferences)
// 2. Core services (LocalStorage, ApiClient)
// 3. API services (PexelsApiService)
// 4. Repositories (FeedRepository, SearchRepository, PinRepository)
// 5. Use cases (FetchHomePins, SearchPins, ToggleLikePin, ToggleSavePin)

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pinterest/core/network/api_client.dart';
import 'package:pinterest/core/network/services/pexels_api_service.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/api_constants.dart';

// Repositories
import 'package:pinterest/features/home/domain/repositories/feed_repository.dart';
import 'package:pinterest/features/home/data/repositories/feed_repository_impl.dart';
import 'package:pinterest/features/search/domain/repositories/search_repository.dart';
import 'package:pinterest/features/search/data/repositories/search_repository_impl.dart';
import 'package:pinterest/features/pin/domain/repositories/pin_repository.dart';
import 'package:pinterest/features/pin/data/repositories/pin_repository_impl.dart';

// Use cases
import 'package:pinterest/features/home/domain/usecases/fetch_home_pins_usecase.dart';
import 'package:pinterest/features/search/domain/usecases/search_pins_usecase.dart';
import 'package:pinterest/features/pin/domain/usecases/toggle_like_pin_usecase.dart';
import 'package:pinterest/features/pin/domain/usecases/toggle_save_pin_usecase.dart';

/// Global service locator instance
final GetIt getIt = GetIt.instance;

/// Initializes all dependencies
///
/// Must be called before runApp() in main.dart.
/// Reads API keys from compile-time environment variables (--dart-define).
///
/// Example usage in main.dart:
/// ```dart
/// Future<void> main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await configureDependencies();
///   runApp(const MyApp());
/// }
/// ```
///
/// Throws [StateError] if API key is missing from environment.
Future<void> configureDependencies() async {
  // Skip if already registered (hot reload safety)
  if (getIt.isRegistered<SharedPreferences>()) return;

  // Register in dependency order
  await _registerExternalServices();
  _registerCoreServices();
  _registerApiServices();
  _registerRepositories();
  _registerUseCases();
}

// ============================================================================
// LAYER 1: External Services
// ============================================================================

/// Registers external/third-party services
///
/// These are async because they may require initialization.
Future<void> _registerExternalServices() async {
  // SharedPreferences - requires async initialization
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
}

// ============================================================================
// LAYER 2: Core Services
// ============================================================================

/// Registers core application services
///
/// These are the foundational services used by other layers.
void _registerCoreServices() {
  // LocalStorageService - wraps SharedPreferences
  getIt.registerLazySingleton<LocalStorageService>(
    () => SharedPreferencesStorageService(
      preferences: getIt<SharedPreferences>(),
    ),
  );

  // ApiClient - configured Dio instance with interceptors
  // API key is loaded from .env file
  final apiKey = dotenv.env[ApiConstants.pexelsApiKeyEnvVar];
  if (apiKey == null || apiKey.isEmpty) {
    throw StateError(
      'PEXELS_API_KEY not found in assets/.env file. '
      'Please add: PEXELS_API_KEY=your_api_key',
    );
  }

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(apiKey: apiKey),
  );

  // Expose Dio directly for services that need it
  getIt.registerLazySingleton<Dio>(
    () => getIt<ApiClient>().dio,
  );
}

// ============================================================================
// LAYER 3: API Services
// ============================================================================

/// Registers API service classes
///
/// These services handle direct communication with external APIs.
void _registerApiServices() {
  // PexelsApiService - handles all Pexels API calls
  getIt.registerLazySingleton<PexelsApiService>(
    () => PexelsApiService(dio: getIt<Dio>()),
  );
}

// ============================================================================
// LAYER 4: Repositories
// ============================================================================

/// Registers repository implementations
///
/// Repositories are registered as their abstract interfaces
/// to enable easy testing and swapping implementations.
void _registerRepositories() {
  // FeedRepository - home feed operations
  getIt.registerLazySingleton<FeedRepository>(
    () => FeedRepositoryImpl(
      apiService: getIt<PexelsApiService>(),
    ),
  );

  // SearchRepository - search operations
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      apiService: getIt<PexelsApiService>(),
      localStorage: getIt<LocalStorageService>(),
    ),
  );

  // PinRepository - pin interactions
  getIt.registerLazySingleton<PinRepository>(
    () => PinRepositoryImpl(
      localStorage: getIt<LocalStorageService>(),
    ),
  );
}

// ============================================================================
// LAYER 5: Use Cases
// ============================================================================

/// Registers use case classes
///
/// Use cases are registered as factories since they are lightweight
/// and may be instantiated multiple times.
/// Alternative: Use lazy singletons if use cases maintain no state.
void _registerUseCases() {
  // FetchHomePinsUseCase
  getIt.registerLazySingleton<FetchHomePinsUseCase>(
    () => FetchHomePinsUseCase(
      repository: getIt<FeedRepository>(),
    ),
  );

  // SearchPinsUseCase
  getIt.registerLazySingleton<SearchPinsUseCase>(
    () => SearchPinsUseCase(
      repository: getIt<SearchRepository>(),
    ),
  );

  // ToggleLikePinUseCase
  getIt.registerLazySingleton<ToggleLikePinUseCase>(
    () => ToggleLikePinUseCase(
      repository: getIt<PinRepository>(),
    ),
  );

  // ToggleSavePinUseCase
  getIt.registerLazySingleton<ToggleSavePinUseCase>(
    () => ToggleSavePinUseCase(
      repository: getIt<PinRepository>(),
    ),
  );
}

// ============================================================================
// Helper Functions
// ============================================================================

/// Resets all registered dependencies
///
/// Useful for testing or when needing to reinitialize dependencies.
Future<void> resetDependencies() async {
  await getIt.reset();
}

/// Checks if dependencies have been initialized
bool get dependenciesInitialized => getIt.isRegistered<PexelsApiService>();
