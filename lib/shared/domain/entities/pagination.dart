// Pagination domain entity
// Shared pagination model for paginated API responses

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';
part 'pagination.g.dart';

/// Domain entity representing pagination state
/// 
/// Used to track pagination across the app for any paginated data source.
@freezed
class Pagination with _$Pagination {
  const Pagination._();

  const factory Pagination({
    @Default(1) int currentPage,
    @Default(15) int perPage,
    @Default(0) int totalResults,
    @Default(false) bool hasNextPage,
    @Default(false) bool isLoading,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  /// Calculate total number of pages
  int get totalPages => perPage > 0 ? (totalResults / perPage).ceil() : 0;

  /// Get the next page number, or null if no more pages
  int? get nextPage => hasNextPage ? currentPage + 1 : null;

  /// Whether we're on the first page
  bool get isFirstPage => currentPage == 1;

  /// Whether we're on the last page
  bool get isLastPage => !hasNextPage;

  /// Create a new pagination state for the next page load
  Pagination startNextPageLoad() => copyWith(isLoading: true);

  /// Create a pagination state after successful page load
  Pagination onPageLoaded({
    required int page,
    required int totalResults,
    required bool hasNextPage,
  }) =>
      copyWith(
        currentPage: page,
        totalResults: totalResults,
        hasNextPage: hasNextPage,
        isLoading: false,
      );

  /// Reset pagination to initial state
  Pagination reset() => const Pagination();
}
