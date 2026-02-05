// ignore_for_file: invalid_annotation_target

// Saved pins state with Freezed
// Immutable state for saved/liked pins

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';

part 'saved_pins_state.freezed.dart';
part 'saved_pins_state.g.dart';

/// Immutable state for saved and liked pins
///
/// Designed for efficient grid UI updates:
/// - Uses `Set<String>` for `O(1)` lookup
/// - Stores full Pin objects for instant display
/// - Tracks last update for change detection
@freezed
class SavedPinsState with _$SavedPinsState {
  const SavedPinsState._();

  const factory SavedPinsState({
    /// Map of saved pins by ID for O(1) access
    @Default({}) Map<String, Pin> savedPinsMap,

    /// Set of saved pin IDs for quick lookup
    @Default({}) Set<String> savedPinIds,

    /// Set of liked pin IDs
    @Default({}) Set<String> likedPinIds,

    /// Pin ID -> search query when pin was saved from search (for "Ideas for you")
    @Default({}) Map<String, String> savedPinSourceQueries,

    /// Whether state is currently loading
    @Default(false) bool isLoading,

    /// Whether initial load is complete
    @Default(false) bool isInitialized,

    /// Error message if any
    String? error,

    /// Last update timestamp for change detection
    DateTime? lastUpdated,

    /// Version counter for efficient rebuilds
    @Default(0) int version,
  }) = _SavedPinsState;

  factory SavedPinsState.fromJson(Map<String, dynamic> json) =>
      _$SavedPinsStateFromJson(json);

  // =========================================================================
  // Computed Properties
  // =========================================================================

  /// List of saved pins (ordered by save time, newest first)
  List<Pin> get savedPins => savedPinsMap.values.toList();

  /// Check if a pin is saved
  bool isPinSaved(String pinId) => savedPinIds.contains(pinId);

  /// Check if a pin is liked
  bool isPinLiked(String pinId) => likedPinIds.contains(pinId);

  /// Get a saved pin by ID
  Pin? getSavedPin(String pinId) => savedPinsMap[pinId];

  /// Total count of saved pins
  int get savedCount => savedPinIds.length;

  /// Total count of liked pins
  int get likedCount => likedPinIds.length;

  /// Whether there are any saved pins
  bool get hasSavedPins => savedPinIds.isNotEmpty;

  /// Whether there are any liked pins
  bool get hasLikedPins => likedPinIds.isNotEmpty;

  // =========================================================================
  // Filtering & Sorting
  // =========================================================================

  /// Get saved pins filtered by a predicate
  List<Pin> savedPinsWhere(bool Function(Pin) test) =>
      savedPins.where(test).toList();

  /// Get saved pins sorted by a comparator
  List<Pin> savedPinsSorted(int Function(Pin, Pin) compare) =>
      savedPins..sort(compare);

  /// Get pins that are both saved and liked
  List<Pin> get savedAndLikedPins =>
      savedPins.where((p) => likedPinIds.contains(p.id)).toList();

  // =========================================================================
  // For Grid UI Efficiency
  // =========================================================================

  /// Get pin state for a specific pin (for grid item rebuilds)
  PinSaveState getPinState(String pinId) => PinSaveState(
        isSaved: savedPinIds.contains(pinId),
        isLiked: likedPinIds.contains(pinId),
      );

  /// Check if state has changed since a version
  bool hasChangedSince(int sinceVersion) => version > sinceVersion;
}

/// Lightweight state for a single pin (for efficient grid rebuilds)
class PinSaveState {
  const PinSaveState({
    required this.isSaved,
    required this.isLiked,
  });

  final bool isSaved;
  final bool isLiked;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PinSaveState &&
          isSaved == other.isSaved &&
          isLiked == other.isLiked;

  @override
  int get hashCode => Object.hash(isSaved, isLiked);
}

/// Cached data for persistence
@freezed
class SavedPinsCacheData with _$SavedPinsCacheData {
  const factory SavedPinsCacheData({
    required List<Pin> pins,
    required List<String> savedPinIds,
    required List<String> likedPinIds,
    @Default({}) Map<String, String> savedPinSourceQueries,
    required DateTime cachedAt,
  }) = _SavedPinsCacheData;

  factory SavedPinsCacheData.fromJson(Map<String, dynamic> json) =>
      _$SavedPinsCacheDataFromJson(json);
}
