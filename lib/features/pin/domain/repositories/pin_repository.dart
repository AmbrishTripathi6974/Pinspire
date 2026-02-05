// Abstract pin repository contract
// Defines pin CRUD and interaction operations interface

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

/// Abstract repository interface for pin operations
///
/// Implementations should handle:
/// - Pin CRUD operations
/// - Like/save state management
/// - Local persistence of user interactions
abstract class PinRepository {
  /// Gets a single pin by ID
  ///
  /// [pinId] - The unique identifier of the pin
  ///
  /// Returns [Right] with [Pin] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Pin>> getPinById({
    required String pinId,
  });

  /// Toggles the like state of a pin
  ///
  /// [pinId] - The unique identifier of the pin
  ///
  /// Returns [Right] with updated [Pin] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Pin>> toggleLike({
    required String pinId,
  });

  /// Toggles the save state of a pin
  ///
  /// [pinId] - The unique identifier of the pin
  /// [boardId] - Optional board ID to save the pin to
  ///
  /// Returns [Right] with updated [Pin] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, Pin>> toggleSave({
    required String pinId,
    String? boardId,
  });

  /// Gets all saved pins for the current user
  ///
  /// Returns [Right] with list of saved [Pin]s on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Pin>>> getSavedPins();

  /// Gets all liked pins for the current user
  ///
  /// Returns [Right] with list of liked [Pin]s on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Pin>>> getLikedPins();
}
