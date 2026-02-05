// FetchHomePins use case
// Fetches paginated home feed pins from the repository

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/features/home/domain/repositories/feed_repository.dart';

/// Parameters for fetching home pins
class FetchHomePinsParams {
  const FetchHomePinsParams({
    required this.page,
    this.perPage = 15,
  });

  final int page;
  final int perPage;

  /// Creates params for first page
  factory FetchHomePinsParams.firstPage({int perPage = 15}) =>
      FetchHomePinsParams(page: 1, perPage: perPage);

  /// Creates params for next page
  FetchHomePinsParams nextPage() => FetchHomePinsParams(
        page: page + 1,
        perPage: perPage,
      );
}

/// Use case for fetching paginated home feed pins
///
/// This use case handles:
/// - Fetching curated/trending pins for the home feed
/// - Pagination logic
/// - Validating page parameters
///
/// Example usage:
/// ```dart
/// final useCase = FetchHomePinsUseCase(repository: feedRepository);
/// final result = await useCase(FetchHomePinsParams(page: 1));
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (pinsResult) => print('Got ${pinsResult.pins.length} pins'),
/// );
/// ```
class FetchHomePinsUseCase {
  const FetchHomePinsUseCase({
    required FeedRepository repository,
  }) : _repository = repository;

  final FeedRepository _repository;

  /// Executes the use case
  ///
  /// [params] - Contains page number and items per page
  ///
  /// Returns [Right] with [PaginatedPinsResult] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PaginatedPinsResult>> call(
    FetchHomePinsParams params,
  ) async {
    // Validate page parameter
    if (params.page < 1) {
      return const Left(
        Failure.validation(message: 'Page number must be at least 1'),
      );
    }

    // Validate perPage parameter
    if (params.perPage < 1 || params.perPage > 80) {
      return const Left(
        Failure.validation(message: 'Items per page must be between 1 and 80'),
      );
    }

    return _repository.getHomePins(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
