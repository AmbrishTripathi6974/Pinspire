/// API endpoint path constants
/// All REST API endpoint definitions for Pexels API

abstract class ApiEndpoints {
  /// GET /curated - Get curated photos for home feed
  /// Query params: page, per_page
  static const String curated = '/curated';

  /// GET /search - Search for photos
  /// Query params: query, page, per_page, orientation, size, color, locale
  static const String search = '/search';

  /// GET /photos/:id - Get a specific photo by ID
  static String photo(String id) => '/photos/$id';
}
