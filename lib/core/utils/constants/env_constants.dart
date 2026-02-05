// Environment constants loaded via --dart-define at compile time
// Usage: flutter run --dart-define=PEXELS_API_KEY=xxx --dart-define=CLERK_PUBLISHABLE_KEY=xxx

/// Compile-time environment variables
///
/// All values are loaded via String.fromEnvironment at compile time.
/// This ensures secrets are not hardcoded and can be injected during build.
///
/// For local development, create a `.env` file and use a script to pass values:
/// ```bash
/// flutter run \
///   --dart-define=PEXELS_API_KEY=$(grep PEXELS_API_KEY .env | cut -d '=' -f2) \
///   --dart-define=CLERK_PUBLISHABLE_KEY=$(grep CLERK_PUBLISHABLE_KEY .env | cut -d '=' -f2)
/// ```
///
/// For CI/CD, inject from environment secrets:
/// ```yaml
/// flutter build apk \
///   --dart-define=PEXELS_API_KEY=${{ secrets.PEXELS_API_KEY }} \
///   --dart-define=CLERK_PUBLISHABLE_KEY=${{ secrets.CLERK_PUBLISHABLE_KEY }}
/// ```
abstract final class EnvConstants {
  EnvConstants._();

  // =============================================================================
  // API Keys
  // =============================================================================

  /// Pexels API key for image fetching
  ///
  /// Get your free API key at: https://www.pexels.com/api/
  static const String pexelsApiKey = String.fromEnvironment(
    'PEXELS_API_KEY',
    defaultValue: '',
  );

  /// Clerk publishable key for authentication
  ///
  /// Get your key at: https://dashboard.clerk.com/
  static const String clerkPublishableKey = String.fromEnvironment(
    'CLERK_PUBLISHABLE_KEY',
    defaultValue: '',
  );

  // =============================================================================
  // OAuth Configuration
  // =============================================================================

  /// Google OAuth Client ID (for native Google Sign-In)
  ///
  /// Configure in Google Cloud Console
  static const String googleClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue: '',
  );

  /// Google OAuth Client ID for iOS
  static const String googleClientIdIos = String.fromEnvironment(
    'GOOGLE_CLIENT_ID_IOS',
    defaultValue: '',
  );

  /// Google OAuth Client ID for Android
  static const String googleClientIdAndroid = String.fromEnvironment(
    'GOOGLE_CLIENT_ID_ANDROID',
    defaultValue: '',
  );

  // =============================================================================
  // App Configuration
  // =============================================================================

  /// Current environment (development, staging, production)
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// Whether the app is running in production mode
  static bool get isProduction => environment == 'production';

  /// Whether the app is running in development mode
  static bool get isDevelopment => environment == 'development';

  /// Whether the app is running in staging mode
  static bool get isStaging => environment == 'staging';

  // =============================================================================
  // Feature Flags
  // =============================================================================

  /// Enable detailed logging
  static const bool enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );

  /// Enable performance monitoring
  static const bool enablePerformanceMonitoring = bool.fromEnvironment(
    'ENABLE_PERFORMANCE_MONITORING',
    defaultValue: false,
  );

  /// Enable crash reporting
  static const bool enableCrashReporting = bool.fromEnvironment(
    'ENABLE_CRASH_REPORTING',
    defaultValue: false,
  );

  // =============================================================================
  // Validation
  // =============================================================================

  /// Checks if all required environment variables are set
  static bool get isConfigured =>
      pexelsApiKey.isNotEmpty && clerkPublishableKey.isNotEmpty;

  /// Returns list of missing required environment variables
  static List<String> get missingVariables {
    final missing = <String>[];
    if (pexelsApiKey.isEmpty) missing.add('PEXELS_API_KEY');
    if (clerkPublishableKey.isEmpty) missing.add('CLERK_PUBLISHABLE_KEY');
    return missing;
  }
}
