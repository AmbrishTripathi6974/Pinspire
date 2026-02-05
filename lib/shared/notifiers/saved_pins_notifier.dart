// SavedPins StateNotifier with SharedPreferences persistence
// Manages saved/liked pins state with automatic persistence

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/shared/state/saved_pins_state.dart';

/// StateNotifier for saved and liked pins
///
/// Features:
/// - Automatic persistence to SharedPreferences
/// - Full pin data storage for instant display
/// - Version tracking for efficient UI rebuilds
/// - Cross-screen state sync via Riverpod
/// - Batch operations for performance
class SavedPinsNotifier extends StateNotifier<SavedPinsState> {
  SavedPinsNotifier({
    required LocalStorageService localStorage,
  })  : _localStorage = localStorage,
        super(const SavedPinsState()) {
    _loadPersistedState();
  }

  final LocalStorageService _localStorage;

  // =========================================================================
  // Initialization & Persistence
  // =========================================================================

  /// Loads persisted state from SharedPreferences
  Future<void> _loadPersistedState() async {
    state = state.copyWith(isLoading: true);

    try {
      // Load saved pins with full data
      final cacheJson = _localStorage.getJson(StorageKeys.savedPinsCache);
      
      if (cacheJson != null) {
        final cacheData = SavedPinsCacheData.fromJson(cacheJson);
        
        // Build pins map from cached data
        final pinsMap = <String, Pin>{};
        for (final pin in cacheData.pins) {
          pinsMap[pin.id] = pin.copyWith(saved: true);
        }

        state = state.copyWith(
          savedPinsMap: pinsMap,
          savedPinIds: cacheData.savedPinIds.toSet(),
          likedPinIds: cacheData.likedPinIds.toSet(),
          savedPinSourceQueries: cacheData.savedPinSourceQueries,
          isLoading: false,
          isInitialized: true,
          lastUpdated: cacheData.cachedAt,
          error: null,
        );
      } else {
        // Fallback: Load just IDs (legacy format)
        final savedPinIds =
            _localStorage.getStringList(StorageKeys.savedPins)?.toSet() ?? {};
        final likedPinIds =
            _localStorage.getStringList(StorageKeys.likedPins)?.toSet() ?? {};

        state = state.copyWith(
          savedPinIds: savedPinIds,
          likedPinIds: likedPinIds,
          savedPinSourceQueries: {},
          isLoading: false,
          isInitialized: true,
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        error: 'Failed to load saved pins',
      );
    }
  }

  /// Persists current state to SharedPreferences
  Future<void> _persistState() async {
    try {
      // Save full cache data
      final cacheData = SavedPinsCacheData(
        pins: state.savedPins,
        savedPinIds: state.savedPinIds.toList(),
        likedPinIds: state.likedPinIds.toList(),
        savedPinSourceQueries: state.savedPinSourceQueries,
        cachedAt: DateTime.now(),
      );

      await _localStorage.setJson(
        StorageKeys.savedPinsCache,
        cacheData.toJson(),
      );

      // Also save IDs separately for quick access
      await _localStorage.setStringList(
        StorageKeys.savedPins,
        state.savedPinIds.toList(),
      );
      await _localStorage.setStringList(
        StorageKeys.likedPins,
        state.likedPinIds.toList(),
      );
    } catch (_) {
      // Silently fail - UI state is more important than persistence errors
    }
  }

  /// Increments version for efficient UI updates
  void _incrementVersion() {
    state = state.copyWith(
      version: state.version + 1,
      lastUpdated: DateTime.now(),
    );
  }

  // =========================================================================
  // Save Operations
  // =========================================================================

  /// Toggles save state for a pin.
  /// [sourceQuery] optional; when saving from search, pass the search query for "Ideas for you".
  Future<void> toggleSavePin(Pin pin, {String? sourceQuery}) async {
    final pinId = pin.id;
    final newSavedIds = Set<String>.from(state.savedPinIds);
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    final newSourceQueries = Map<String, String>.from(state.savedPinSourceQueries);

    if (newSavedIds.contains(pinId)) {
      // Unsave
      newSavedIds.remove(pinId);
      newPinsMap.remove(pinId);
      newSourceQueries.remove(pinId);
    } else {
      // Save
      newSavedIds.add(pinId);
      newPinsMap[pinId] = pin.copyWith(
        saved: true,
        liked: state.likedPinIds.contains(pinId),
      );
      if (sourceQuery != null && sourceQuery.trim().isNotEmpty) {
        newSourceQueries[pinId] = sourceQuery.trim();
      }
    }

    state = state.copyWith(
      savedPinIds: newSavedIds,
      savedPinsMap: newPinsMap,
      savedPinSourceQueries: newSourceQueries,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Saves a pin (adds if not already saved)
  Future<void> savePin(Pin pin) async {
    if (state.savedPinIds.contains(pin.id)) return;

    final newSavedIds = Set<String>.from(state.savedPinIds)..add(pin.id);
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    newPinsMap[pin.id] = pin.copyWith(
      saved: true,
      liked: state.likedPinIds.contains(pin.id),
    );

    state = state.copyWith(
      savedPinIds: newSavedIds,
      savedPinsMap: newPinsMap,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Unsaves a pin by ID
  Future<void> unsavePin(String pinId) async {
    if (!state.savedPinIds.contains(pinId)) return;

    final newSavedIds = Set<String>.from(state.savedPinIds)..remove(pinId);
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap)..remove(pinId);
    final newSourceQueries = Map<String, String>.from(state.savedPinSourceQueries)..remove(pinId);

    state = state.copyWith(
      savedPinIds: newSavedIds,
      savedPinsMap: newPinsMap,
      savedPinSourceQueries: newSourceQueries,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Batch save multiple pins (efficient for bulk operations)
  Future<void> savePins(List<Pin> pins) async {
    if (pins.isEmpty) return;

    final newSavedIds = Set<String>.from(state.savedPinIds);
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);

    for (final pin in pins) {
      if (!newSavedIds.contains(pin.id)) {
        newSavedIds.add(pin.id);
        newPinsMap[pin.id] = pin.copyWith(
          saved: true,
          liked: state.likedPinIds.contains(pin.id),
        );
      }
    }

    state = state.copyWith(
      savedPinIds: newSavedIds,
      savedPinsMap: newPinsMap,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Batch unsave multiple pins
  Future<void> unsavePins(List<String> pinIds) async {
    if (pinIds.isEmpty) return;

    final newSavedIds = Set<String>.from(state.savedPinIds);
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    final newSourceQueries = Map<String, String>.from(state.savedPinSourceQueries);

    for (final pinId in pinIds) {
      newSavedIds.remove(pinId);
      newPinsMap.remove(pinId);
      newSourceQueries.remove(pinId);
    }

    state = state.copyWith(
      savedPinIds: newSavedIds,
      savedPinsMap: newPinsMap,
      savedPinSourceQueries: newSourceQueries,
    );

    _incrementVersion();
    await _persistState();
  }

  // =========================================================================
  // Like Operations
  // =========================================================================

  /// Toggles like state for a pin
  Future<void> toggleLikePin(String pinId) async {
    final newLikedIds = Set<String>.from(state.likedPinIds);
    final isLiking = !newLikedIds.contains(pinId);

    if (isLiking) {
      newLikedIds.add(pinId);
    } else {
      newLikedIds.remove(pinId);
    }

    // Update pin data if it exists in saved pins
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    if (newPinsMap.containsKey(pinId)) {
      newPinsMap[pinId] = newPinsMap[pinId]!.copyWith(liked: isLiking);
    }

    state = state.copyWith(
      likedPinIds: newLikedIds,
      savedPinsMap: newPinsMap,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Like a pin
  Future<void> likePin(String pinId) async {
    if (state.likedPinIds.contains(pinId)) return;

    final newLikedIds = Set<String>.from(state.likedPinIds)..add(pinId);

    // Update pin data if it exists
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    if (newPinsMap.containsKey(pinId)) {
      newPinsMap[pinId] = newPinsMap[pinId]!.copyWith(liked: true);
    }

    state = state.copyWith(
      likedPinIds: newLikedIds,
      savedPinsMap: newPinsMap,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Unlike a pin
  Future<void> unlikePin(String pinId) async {
    if (!state.likedPinIds.contains(pinId)) return;

    final newLikedIds = Set<String>.from(state.likedPinIds)..remove(pinId);

    // Update pin data if it exists
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    if (newPinsMap.containsKey(pinId)) {
      newPinsMap[pinId] = newPinsMap[pinId]!.copyWith(liked: false);
    }

    state = state.copyWith(
      likedPinIds: newLikedIds,
      savedPinsMap: newPinsMap,
    );

    _incrementVersion();
    await _persistState();
  }

  // =========================================================================
  // Pin Data Management
  // =========================================================================

  /// Updates pin data for an already saved pin
  void updatePinData(Pin pin) {
    if (!state.savedPinIds.contains(pin.id)) return;

    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    newPinsMap[pin.id] = pin.copyWith(
      saved: true,
      liked: state.likedPinIds.contains(pin.id),
    );

    state = state.copyWith(savedPinsMap: newPinsMap);
    _incrementVersion();
  }

  /// Batch update pin data
  void updatePinsData(List<Pin> pins) {
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    var hasChanges = false;

    for (final pin in pins) {
      if (state.savedPinIds.contains(pin.id)) {
        newPinsMap[pin.id] = pin.copyWith(
          saved: true,
          liked: state.likedPinIds.contains(pin.id),
        );
        hasChanges = true;
      }
    }

    if (hasChanges) {
      state = state.copyWith(savedPinsMap: newPinsMap);
      _incrementVersion();
    }
  }

  /// Adds pin data for a saved pin ID that doesn't have full data yet
  void hydratePinData(Pin pin) {
    if (!state.savedPinIds.contains(pin.id)) return;
    if (state.savedPinsMap.containsKey(pin.id)) return;

    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    newPinsMap[pin.id] = pin.copyWith(
      saved: true,
      liked: state.likedPinIds.contains(pin.id),
    );

    state = state.copyWith(savedPinsMap: newPinsMap);
  }

  // =========================================================================
  // Clear Operations
  // =========================================================================

  /// Clears all saved pins
  Future<void> clearAllSaved() async {
    state = state.copyWith(
      savedPinsMap: {},
      savedPinIds: {},
      savedPinSourceQueries: {},
    );

    _incrementVersion();
    await _persistState();
  }

  /// Clears all liked pins
  Future<void> clearAllLiked() async {
    // Update pins map to remove like status
    final newPinsMap = Map<String, Pin>.from(state.savedPinsMap);
    for (final entry in newPinsMap.entries) {
      newPinsMap[entry.key] = entry.value.copyWith(liked: false);
    }

    state = state.copyWith(
      likedPinIds: {},
      savedPinsMap: newPinsMap,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Clears all data
  Future<void> clearAll() async {
    state = state.copyWith(
      savedPinsMap: {},
      savedPinIds: {},
      likedPinIds: {},
      savedPinSourceQueries: {},
    );

    _incrementVersion();
    await _persistState();
  }

  /// Clears any error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
