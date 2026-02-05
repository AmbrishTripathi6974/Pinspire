// ToggleSavePin use case
// Toggles the save state of a pin

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/pin/domain/repositories/pin_repository.dart';

/// Parameters for toggling pin save state
class ToggleSavePinParams {
  const ToggleSavePinParams({
    required this.pinId,
    this.boardId,
  });

  final String pinId;

  /// Optional board ID to save the pin to
  /// If null, the pin is saved to the default/unsorted collection
  final String? boardId;

  /// Creates params for saving to a specific board
  factory ToggleSavePinParams.toBoard({
    required String pinId,
    required String boardId,
  }) =>
      ToggleSavePinParams(
        pinId: pinId,
        boardId: boardId,
      );
}

/// Use case for toggling the save state of a pin
///
/// This use case handles:
/// - Saving/unsaving a pin
/// - Optionally saving to a specific board
/// - Validating parameters
/// - Returning updated pin state
///
/// Business rules:
/// - If pin is not saved, it becomes saved
/// - If pin is already saved, it becomes unsaved
/// - When saving, a board can optionally be specified
/// - The returned pin reflects the new save state
///
/// Example usage:
/// ```dart
/// final useCase = ToggleSavePinUseCase(repository: pinRepository);
///
/// // Save to default collection
/// final result = await useCase(ToggleSavePinParams(pinId: '123'));
///
/// // Save to specific board
/// final result = await useCase(
///   ToggleSavePinParams.toBoard(pinId: '123', boardId: 'board-456'),
/// );
///
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (pin) => print('Pin ${pin.saved ? "saved" : "unsaved"}'),
/// );
/// ```
class ToggleSavePinUseCase {
  const ToggleSavePinUseCase({
    required PinRepository repository,
  }) : _repository = repository;

  final PinRepository _repository;

  /// Executes the use case
  ///
  /// [params] - Contains the pin ID and optional board ID
  ///
  /// Returns [Right] with updated [Pin] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Pin>> call(ToggleSavePinParams params) async {
    // Validate pin ID is not empty
    if (params.pinId.trim().isEmpty) {
      return const Left(
        Failure.validation(message: 'Pin ID cannot be empty'),
      );
    }

    // Validate board ID if provided
    if (params.boardId != null && params.boardId!.trim().isEmpty) {
      return const Left(
        Failure.validation(message: 'Board ID cannot be empty if provided'),
      );
    }

    return _repository.toggleSave(
      pinId: params.pinId,
      boardId: params.boardId,
    );
  }
}
