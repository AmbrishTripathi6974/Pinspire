// ToggleLikePin use case
// Toggles the like state of a pin

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/pin/domain/repositories/pin_repository.dart';

/// Parameters for toggling pin like state
class ToggleLikePinParams {
  const ToggleLikePinParams({
    required this.pinId,
  });

  final String pinId;
}

/// Use case for toggling the like state of a pin
///
/// This use case handles:
/// - Toggling like/unlike on a pin
/// - Validating pin ID
/// - Returning updated pin state
///
/// Business rules:
/// - If pin is not liked, it becomes liked
/// - If pin is already liked, it becomes unliked
/// - The returned pin reflects the new like state
///
/// Example usage:
/// ```dart
/// final useCase = ToggleLikePinUseCase(repository: pinRepository);
/// final result = await useCase(ToggleLikePinParams(pinId: '123'));
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (pin) => print('Pin ${pin.liked ? "liked" : "unliked"}'),
/// );
/// ```
class ToggleLikePinUseCase {
  const ToggleLikePinUseCase({
    required PinRepository repository,
  }) : _repository = repository;

  final PinRepository _repository;

  /// Executes the use case
  ///
  /// [params] - Contains the pin ID to toggle like state
  ///
  /// Returns [Right] with updated [Pin] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Pin>> call(ToggleLikePinParams params) async {
    // Validate pin ID is not empty
    if (params.pinId.trim().isEmpty) {
      return const Left(
        Failure.validation(message: 'Pin ID cannot be empty'),
      );
    }

    return _repository.toggleLike(pinId: params.pinId);
  }
}
