// Pin repository implementation
// Handles pin interactions with local persistence

import 'package:fpdart/fpdart.dart';
import 'package:pinterest/core/error/failures.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/pin/domain/repositories/pin_repository.dart';

/// Storage keys for pin interactions
abstract class _StorageKeys {
  static const String likedPins = 'liked_pins';
  static const String savedPins = 'saved_pins';
  static const String pinCache = 'pin_cache';
}

/// Implementation of [PinRepository]
///
/// Handles:
/// - Like/save state management in local storage
/// - Pin caching for offline access
/// - Retrieving liked and saved pins
///
/// Note: Since Pexels API doesn't support user interactions,
/// like/save states are managed locally.
class PinRepositoryImpl implements PinRepository {
  const PinRepositoryImpl({
    required LocalStorageService localStorage,
  }) : _localStorage = localStorage;

  final LocalStorageService _localStorage;

  @override
  Future<Either<Failure, Pin>> getPinById({
    required String pinId,
  }) async {
    try {
      // Try to get from cache
      final cachedPins = _getCachedPins();
      final pin = cachedPins[pinId];

      if (pin != null) {
        // Apply current like/save state
        return Right(_applyInteractionState(pin));
      }

      return const Left(Failure.notFound(message: 'Pin not found'));
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to retrieve pin'));
    }
  }

  @override
  Future<Either<Failure, Pin>> toggleLike({
    required String pinId,
  }) async {
    try {
      final likedIds = _getLikedPinIds();
      final isCurrentlyLiked = likedIds.contains(pinId);

      if (isCurrentlyLiked) {
        likedIds.remove(pinId);
      } else {
        likedIds.add(pinId);
      }

      await _localStorage.setStringList(_StorageKeys.likedPins, likedIds);

      // Get the pin and return with updated state
      final cachedPins = _getCachedPins();
      final pin = cachedPins[pinId];

      if (pin != null) {
        final updatedPin = pin.copyWith(liked: !isCurrentlyLiked);
        // Update cache with new state
        await _cachePin(updatedPin);
        return Right(updatedPin);
      }

      // If pin not in cache, return a minimal pin with the new state
      return Right(
        Pin(
          id: pinId,
          imageUrl: '',
          width: 0,
          height: 0,
          liked: !isCurrentlyLiked,
          saved: _getSavedPinIds().contains(pinId),
        ),
      );
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to toggle like'));
    }
  }

  @override
  Future<Either<Failure, Pin>> toggleSave({
    required String pinId,
    String? boardId,
  }) async {
    try {
      final savedIds = _getSavedPinIds();
      final isCurrentlySaved = savedIds.contains(pinId);

      if (isCurrentlySaved) {
        savedIds.remove(pinId);
      } else {
        savedIds.add(pinId);
      }

      await _localStorage.setStringList(_StorageKeys.savedPins, savedIds);

      // Get the pin and return with updated state
      final cachedPins = _getCachedPins();
      final pin = cachedPins[pinId];

      if (pin != null) {
        final updatedPin = pin.copyWith(saved: !isCurrentlySaved);
        // Update cache with new state
        await _cachePin(updatedPin);
        return Right(updatedPin);
      }

      // If pin not in cache, return a minimal pin with the new state
      return Right(
        Pin(
          id: pinId,
          imageUrl: '',
          width: 0,
          height: 0,
          liked: _getLikedPinIds().contains(pinId),
          saved: !isCurrentlySaved,
        ),
      );
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to toggle save'));
    }
  }

  @override
  Future<Either<Failure, List<Pin>>> getSavedPins() async {
    try {
      final savedIds = _getSavedPinIds();
      final cachedPins = _getCachedPins();

      final savedPins = savedIds
          .map((id) => cachedPins[id])
          .whereType<Pin>()
          .map(_applyInteractionState)
          .toList();

      return Right(savedPins);
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to get saved pins'));
    }
  }

  @override
  Future<Either<Failure, List<Pin>>> getLikedPins() async {
    try {
      final likedIds = _getLikedPinIds();
      final cachedPins = _getCachedPins();

      final likedPins = likedIds
          .map((id) => cachedPins[id])
          .whereType<Pin>()
          .map(_applyInteractionState)
          .toList();

      return Right(likedPins);
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to get liked pins'));
    }
  }

  /// Caches a pin for later retrieval
  Future<void> cachePin(Pin pin) async {
    await _cachePin(pin);
  }

  /// Caches multiple pins
  Future<void> cachePins(List<Pin> pins) async {
    final cachedPins = _getCachedPins();

    for (final pin in pins) {
      cachedPins[pin.id] = pin;
    }

    final jsonList = cachedPins.values.map((p) => p.toJson()).toList();
    await _localStorage.setJsonList(_StorageKeys.pinCache, jsonList);
  }

  // Private helper methods

  List<String> _getLikedPinIds() {
    return _localStorage.getStringList(_StorageKeys.likedPins) ?? [];
  }

  List<String> _getSavedPinIds() {
    return _localStorage.getStringList(_StorageKeys.savedPins) ?? [];
  }

  Map<String, Pin> _getCachedPins() {
    final jsonList = _localStorage.getJsonList(_StorageKeys.pinCache);
    if (jsonList == null) return {};

    final pins = <String, Pin>{};
    for (final json in jsonList) {
      try {
        final pin = Pin.fromJson(json);
        pins[pin.id] = pin;
      } catch (_) {
        // Skip invalid entries
      }
    }
    return pins;
  }

  Future<void> _cachePin(Pin pin) async {
    final cachedPins = _getCachedPins();
    cachedPins[pin.id] = pin;

    final jsonList = cachedPins.values.map((p) => p.toJson()).toList();
    await _localStorage.setJsonList(_StorageKeys.pinCache, jsonList);
  }

  Pin _applyInteractionState(Pin pin) {
    final isLiked = _getLikedPinIds().contains(pin.id);
    final isSaved = _getSavedPinIds().contains(pin.id);

    return pin.copyWith(liked: isLiked, saved: isSaved);
  }
}
