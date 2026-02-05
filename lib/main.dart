// Bootstrap entry point for Pinterest Clone
// Handles all initialization before app starts
// No UI logic - only configuration and dependency setup

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pinterest/app.dart';
import 'package:pinterest/core/di/injection.dart';
import 'package:pinterest/core/router/app_router.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/shared/state/navigation_state.dart';

Future<void> main() async {
  // Catch all errors during initialization
  await runZonedGuarded(
    () async {
      // Ensure Flutter bindings are initialized before any async work
      WidgetsFlutterBinding.ensureInitialized();

      // Keep native splash visible until Flutter is ready (prevents white flicker)
      final widgetsBinding = WidgetsBinding.instance;
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Load environment variables from .env file
      await dotenv.load(fileName: 'assets/.env');

      // Configure system UI (status bar, navigation bar)
      await _configureSystemUI();

      // Initialize all dependencies (SharedPreferences, ApiClient, etc.)
      await _initializeDependencies();

      // Load last selected tab so router is built once with correct initial location.
      // Avoids watching navigation state in routerProvider (which caused flicker/rebuilds).
      final localStorage = getIt<LocalStorageService>();
      final tabIndex = localStorage.getInt(StorageKeys.lastSelectedTab);
      final initialTab = (tabIndex != null &&
              tabIndex >= 0 &&
              tabIndex < AppTab.values.length)
          ? tabIndex
          : null;

      // Check if user is logged in from local storage
      // This allows immediate navigation to home feed without waiting for Clerk auth check
      final isLoggedIn = localStorage.getBool(StorageKeys.isLoggedIn) ?? false;

      // Configure image cache for Pinterest-style heavy image usage
      _configureImageCache();

      // Pre-cache Poppins font to avoid flash of unstyled text (FOUT)
      await _prefetchFonts();

      // Run the app wrapped with Riverpod; override initial tab so GoRouter
      // is built once and never rebuilt on tab switch.
      runApp(
        ProviderScope(
          overrides: [
            initialTabIndexProvider.overrideWith((ref) => initialTab),
            isLoggedInFlagProvider.overrideWith((ref) => isLoggedIn),
          ],
          child: const PinterestApp(),
        ),
      );
    },
    (error, stackTrace) {
      // Log fatal errors in production
      if (kDebugMode) {
        debugPrint('Fatal error: $error');
        debugPrint('Stack trace: $stackTrace');
      }
    },
  );
}

/// Configures system UI overlay styles
Future<void> _configureSystemUI() async {
  // Set preferred orientations (portrait only for Pinterest-like app)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configure system UI overlay style for black splash screen
  // Light icons on dark background (matches black splash)
  // MaterialApp theme will override this after splash is removed
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Light icons for dark splash
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black, // Black nav bar to match splash
      systemNavigationBarIconBrightness: Brightness.light, // Light icons
    ),
  );
}

/// Initializes all dependencies via get_it
///
/// Must complete before runApp() is called.
/// Environment variables are loaded from assets/.env file.
Future<void> _initializeDependencies() async {
  // Configure all dependencies
  await configureDependencies();
}

/// Configures Flutter's image cache for optimal performance
///
/// Pinterest-style apps require aggressive caching for smooth scrolling
/// through large image grids.
/// Production-optimized: balances memory usage with performance.
void _configureImageCache() {
  final imageCache = PaintingBinding.instance.imageCache;

  // Production-optimized cache limits for image-heavy app
  // Default: 100 images / 100MB
  // Optimized: 250 images / 200MB for better performance
  // Uses more memory but provides smoother scrolling experience
  imageCache.maximumSize = 250;
  imageCache.maximumSizeBytes = 200 << 20; // 200 MB
  
  // Set eviction policy to be less aggressive
  // This prevents premature cache clearing during scrolling
  imageCache.clearLiveImages();
}

/// Pre-fetches Poppins font variants to avoid FOUT (Flash of Unstyled Text)
///
/// This ensures the font is loaded before the app renders, providing
/// a smoother user experience without visible font swapping.
Future<void> _prefetchFonts() async {
  // Allow HTTP fetching for Google Fonts (required for font loading)
  GoogleFonts.config.allowRuntimeFetching = true;

  // Pre-cache commonly used Poppins font weights
  // These are the most frequently used weights in the app
  await Future.wait([
    // Regular (400)
    GoogleFonts.pendingFonts([
      GoogleFonts.poppins(fontWeight: FontWeight.w400),
    ]),
    // Medium (500)
    GoogleFonts.pendingFonts([
      GoogleFonts.poppins(fontWeight: FontWeight.w500),
    ]),
    // SemiBold (600)
    GoogleFonts.pendingFonts([
      GoogleFonts.poppins(fontWeight: FontWeight.w600),
    ]),
    // Bold (700)
    GoogleFonts.pendingFonts([
      GoogleFonts.poppins(fontWeight: FontWeight.w700),
    ]),
  ]);
}
