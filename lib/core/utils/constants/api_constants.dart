/// API and environment constants
abstract class ApiConstants {
  // ============================================================================
  // Pexels API
  // ============================================================================

  /// Pexels API base URL
  static const String baseUrl = 'https://api.pexels.com/v1';

  /// Connection timeout in milliseconds
  static const int connectTimeout = 30000;

  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;

  /// Send timeout in milliseconds
  static const int sendTimeout = 30000;

  /// Default items per page for pagination
  static const int defaultPerPage = 15;

  /// Maximum items per page allowed by Pexels API
  static const int maxPerPage = 80;

  /// Environment variable key for Pexels API key
  static const String pexelsApiKeyEnvVar = 'PEXELS_API_KEY';

  // ============================================================================
  // Clerk Authentication
  // ============================================================================

  /// Environment variable key for Clerk publishable key
  static const String clerkPublishableKeyEnvVar = 'CLERK_PUBLISHABLE_KEY';

  /// Environment variable key for Google Client ID (for OAuth)
  static const String googleClientIdEnvVar = 'GOOGLE_CLIENT_ID';
}
