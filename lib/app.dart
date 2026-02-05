// Root application widget
// Configures MaterialApp.router, theme, and authentication
// No business logic or DI registration

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pinterest/core/router/app_router.dart';
import 'package:pinterest/core/widgets/loading/masonry_skeleton.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/core/utils/constants/api_constants.dart';
import 'package:pinterest/features/auth/presentation/pages/login_page.dart';
import 'package:pinterest/features/auth/presentation/widgets/auth_gate.dart';
import 'package:pinterest/features/home/presentation/providers/feed_provider.dart';
import 'package:pinterest/features/onboarding/presentation/pages/post_login_onboarding_page.dart';
import 'package:pinterest/shared/providers/app_providers.dart';
import 'dart:async';

/// Root widget for the Pinterest Clone application
///
/// Responsibilities:
/// - Wraps app with Clerk authentication
/// - Provides MaterialApp.router configuration
/// - Applies global theme (Pinterest-like)
/// - Handles authenticated vs unauthenticated routing
class PinterestApp extends ConsumerWidget {
  const PinterestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clerkKey = dotenv.env[ApiConstants.clerkPublishableKeyEnvVar];

    // Show error if Clerk key is not configured
    if (clerkKey == null || clerkKey.isEmpty) {
      return _buildErrorApp(
        'Clerk publishable key not configured.\n'
        'Please add CLERK_PUBLISHABLE_KEY to assets/.env',
      );
    }

    // Wrap entire app with Clerk authentication
    // Disable telemetry to avoid ClientException when clerk-telemetry.com is unreachable
    // Explicit loading avoids blank screen while Clerk initializes session
    return ClerkAuth(
      config: ClerkAuthConfig(
        publishableKey: clerkKey,
        telemetryPeriod: Duration.zero,
        loading: PinterestDotsLoader.centered(),
      ),
      child: _AppContent(),
    );
  }

  /// Builds error app when configuration is missing
  Widget _buildErrorApp(String message) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// App content wrapped with Clerk authentication
///
/// Uses AuthGate for clean separation of auth state handling.
/// Handles lifecycle events for memory management.
class _AppContent extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AppContent> createState() => _AppContentState();
}

class _AppContentState extends ConsumerState<_AppContent>
    with WidgetsBindingObserver {
  Timer? _splashRemovalTimer;
  bool _splashRemoved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Native splash will be removed when app initialization is complete
    // This gives time for router and pages to load data
  }

  @override
  void dispose() {
    _splashRemovalTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _handleLifecycleChange(state);
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    _handleMemoryPressure();
  }

  void _handleLifecycleChange(AppLifecycleState state) {
    final imageCache = PaintingBinding.instance.imageCache;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // Pinterest-style: do NOT clear cache on background so images survive.
        // Only reduce limits so new images don't grow cache; existing stay until evicted.
        if (imageCache.currentSize > 100) {
          imageCache.maximumSize = 100;
          imageCache.maximumSizeBytes = 100 << 20;
        }
        break;
      case AppLifecycleState.resumed:
        // Restore full cache when foregrounded
        imageCache.maximumSize = 200;
        imageCache.maximumSizeBytes = 150 << 20;
        // Show skeleton when returning from background so UI has time to load
        // Defer provider modification to avoid "modifying provider during lifecycle" error
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ref.read(appSkeletonProvider.notifier).show();
          }
        });
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        imageCache.clear();
        break;
    }
  }

  void _handleMemoryPressure() {
    final imageCache = PaintingBinding.instance.imageCache;
    imageCache.clear();
    imageCache.clearLiveImages();
  }

  @override
  Widget build(BuildContext context) {
    // Watch app initialization state to control splash removal
    final isAppReady = ref.watch(appInitializationProvider);
    
    // Remove splash when app is ready (auth resolved + router ready + data loaded)
    if (isAppReady && !_splashRemoved) {
      _splashRemoved = true;
      // Remove splash immediately - feed has cached data or is ready
      // No need to wait - cached data is already displayed
      _splashRemovalTimer?.cancel();
      _splashRemovalTimer = Timer(const Duration(milliseconds: 100), () {
        if (mounted) {
          FlutterNativeSplash.remove();
        }
      });
    }
    
    // AuthGate handles navigation decision based on Clerk auth state
    // - Replaces entire screen (not push on top)
    // - Smooth fade transition between states
    // - Syncs auth state to Riverpod automatically
    return AuthGate(
      transitionDuration: const Duration(milliseconds: 400),
      authenticatedBuilder: (context) => _AuthenticatedApp(),
      unauthenticatedBuilder: (context) => _UnauthenticatedApp(),
      loadingBuilder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: ThemeMode.system,
        home: Scaffold(
          body: SafeArea(
            top: true,
            bottom: false,
            child: const MasonrySkeleton(),
          ),
        ),
      ),
      onAuthStateResolved: () {
        // Auth state resolved - app initialization provider will handle splash removal
        // when router and data loading are complete
      },
    );
  }
}

/// Authenticated app with full router navigation
///
/// Shows onboarding flow for first-time users, then main app
class _AuthenticatedApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingProvider);
    final router = ref.watch(routerProvider);

    // Pre-initialize feed provider early to start loading data in parallel
    // This allows feed to load cached data immediately and refresh in background
    // Only do this after onboarding is initialized to avoid unnecessary work
    if (onboardingState.isInitialized && onboardingState.hasCompleted) {
      // Access feed provider to trigger early initialization
      // This will load cached data immediately if available
      ref.read(feedProvider);
    }

    // Wait for onboarding state to initialize
    if (!onboardingState.isInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: ThemeMode.system,
        home: Scaffold(
          body: SafeArea(
            top: true,
            bottom: false,
            child: const MasonrySkeleton(),
          ),
        ),
      );
    }

    // Show onboarding if not completed
    if (!onboardingState.hasCompleted) {
      return ClerkErrorListener(
        child: MaterialApp(
          title: 'Pinterest',
          debugShowCheckedModeBanner: false,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          themeMode: ThemeMode.system,
          scrollBehavior: const _PinterestScrollBehavior(),
          home: PostLoginOnboardingPage(
            onComplete: () {
              // Defer provider invalidation to avoid modifying providers during build
              // The state change from completeOnboarding() will trigger a rebuild,
              // but we need to invalidate after the build cycle completes
              Future.microtask(() {
                ref.invalidate(onboardingProvider);
              });
            },
          ),
        ),
      );
    }

    // Show main app after onboarding is complete
    return ClerkErrorListener(
      child: MaterialApp.router(
        title: 'Pinterest',
        debugShowCheckedModeBanner: false,

        // Router configuration
        routerConfig: router,

        // Theme configuration
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: ThemeMode.system,

        // iOS-style scroll behavior globally
        scrollBehavior: const _PinterestScrollBehavior(),

        // Localization (add if needed)
        // localizationsDelegates: [...],
        // supportedLocales: [...],
      ),
    );
  }
}

/// Unauthenticated app showing login
class _UnauthenticatedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClerkErrorListener(
      child: MaterialApp(
        title: 'Pinterest',
        debugShowCheckedModeBanner: false,
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: ThemeMode.system,
        scrollBehavior: const _PinterestScrollBehavior(),
        home: const LoginPage(),
      ),
    );
  }
}

// =============================================================================
// Theme Configuration
// =============================================================================

/// Pinterest brand color
const _pinterestRed = Color(0xFFE60023);

/// Base Poppins text theme for light mode
TextTheme _buildPoppinsTextTheme(Brightness brightness) {
  final baseTextTheme = brightness == Brightness.light
      ? ThemeData.light().textTheme
      : ThemeData.dark().textTheme;
  
  return GoogleFonts.poppinsTextTheme(baseTextTheme);
}

/// Builds light theme with Pinterest styling and Poppins font
ThemeData _buildLightTheme() {
  // Create Poppins text theme for light mode
  final poppinsTextTheme = _buildPoppinsTextTheme(Brightness.light);
  
  final baseTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _pinterestRed,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: _pinterestRed,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _pinterestRed, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey.shade500,
      ),
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 8,
    ),
    dialogTheme: DialogThemeData(
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      contentTextStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black87,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade200,
      thickness: 1,
    ),
    textTheme: poppinsTextTheme,
    primaryTextTheme: poppinsTextTheme,
  );

  return baseTheme;
}

/// Builds dark theme with Pinterest styling and Poppins font
ThemeData _buildDarkTheme() {
  // Create Poppins text theme for dark mode with proper colors
  final poppinsTextTheme = _buildPoppinsTextTheme(Brightness.dark).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  );
  
  final baseTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _pinterestRed,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.grey.shade900,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: _pinterestRed,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        side: const BorderSide(color: Colors.white54),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade900,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _pinterestRed, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey.shade500,
      ),
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.white70,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 8,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.grey.shade900,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      contentTextStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.white70,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade800,
      thickness: 1,
    ),
    textTheme: poppinsTextTheme,
    primaryTextTheme: poppinsTextTheme,
  );

  return baseTheme;
}

// =============================================================================
// Scroll Behavior
// =============================================================================

/// iOS-style scroll behavior applied globally
///
/// Provides bouncing physics and removes scroll glow on Android.
class _PinterestScrollBehavior extends ScrollBehavior {
  const _PinterestScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // Use iOS-style bouncing physics on all platforms
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Remove Android glow effect for cleaner iOS-like appearance
    return child;
  }
}
