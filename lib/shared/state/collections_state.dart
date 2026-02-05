// ignore_for_file: invalid_annotation_target

// Collections state with Freezed
// Immutable state for boards/collections

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pinterest/features/board/domain/entities/board.dart';

part 'collections_state.freezed.dart';
part 'collections_state.g.dart';

/// Immutable state for boards/collections
///
/// Designed for efficient UI updates:
/// - Uses Map for O(1) board lookup
/// - Tracks version for change detection
/// - Supports pin-to-board mapping for quick queries
@freezed
class CollectionsState with _$CollectionsState {
  const CollectionsState._();

  const factory CollectionsState({
    /// Map of boards by ID for O(1) access
    @Default({}) Map<String, Board> boardsMap,

    /// Ordered list of board IDs (for display order)
    @Default([]) List<String> boardOrder,

    /// Map of pin IDs to board IDs (for reverse lookup)
    @Default({}) Map<String, Set<String>> pinToBoardsMap,

    /// Currently selected board ID
    String? selectedBoardId,

    /// Recently used board IDs (for quick access)
    @Default([]) List<String> recentBoardIds,

    /// Whether state is currently loading
    @Default(false) bool isLoading,

    /// Whether initial load is complete
    @Default(false) bool isInitialized,

    /// Error message if any
    String? error,

    /// Last update timestamp
    DateTime? lastUpdated,

    /// Version counter for efficient rebuilds
    @Default(0) int version,
  }) = _CollectionsState;

  factory CollectionsState.fromJson(Map<String, dynamic> json) =>
      _$CollectionsStateFromJson(json);

  // =========================================================================
  // Board Access
  // =========================================================================

  /// List of all boards in display order
  List<Board> get boards =>
      boardOrder.map((id) => boardsMap[id]).whereType<Board>().toList();

  /// Get board by ID (O(1) lookup)
  Board? getBoardById(String id) => boardsMap[id];

  /// Get the currently selected board
  Board? get selectedBoard =>
      selectedBoardId != null ? boardsMap[selectedBoardId] : null;

  /// Get recently used boards
  List<Board> get recentBoards =>
      recentBoardIds.map((id) => boardsMap[id]).whereType<Board>().toList();

  // =========================================================================
  // Counts & Checks
  // =========================================================================

  /// Total count of boards
  int get boardCount => boardsMap.length;

  /// Total count of pins across all boards
  int get totalPinCount =>
      boards.fold(0, (sum, board) => sum + board.pinCount);

  /// Whether there are any boards
  bool get hasBoards => boardsMap.isNotEmpty;

  /// Whether a board exists
  bool hasBoard(String boardId) => boardsMap.containsKey(boardId);

  // =========================================================================
  // Pin-Board Queries
  // =========================================================================

  /// Get all boards containing a specific pin
  List<Board> getBoardsContainingPin(String pinId) {
    final boardIds = pinToBoardsMap[pinId];
    if (boardIds == null) return [];
    return boardIds.map((id) => boardsMap[id]).whereType<Board>().toList();
  }

  /// Check if a pin is in any board
  bool isPinInAnyBoard(String pinId) => pinToBoardsMap.containsKey(pinId);

  /// Check if a pin is in a specific board
  bool isPinInBoard(String pinId, String boardId) {
    final boardIds = pinToBoardsMap[pinId];
    return boardIds?.contains(boardId) ?? false;
  }

  /// Get count of boards containing a pin
  int boardCountForPin(String pinId) => pinToBoardsMap[pinId]?.length ?? 0;

  // =========================================================================
  // Filtering & Sorting
  // =========================================================================

  /// Get public boards only
  List<Board> get publicBoards => boards.where((b) => !b.isPrivate).toList();

  /// Get private boards only
  List<Board> get privateBoards => boards.where((b) => b.isPrivate).toList();

  /// Get boards sorted by name
  List<Board> get boardsSortedByName =>
      List<Board>.from(boards)..sort((a, b) => a.name.compareTo(b.name));

  /// Get boards sorted by pin count
  List<Board> get boardsSortedByPinCount =>
      List<Board>.from(boards)..sort((a, b) => b.pinCount.compareTo(a.pinCount));

  /// Get boards sorted by update time
  List<Board> get boardsSortedByRecent => List<Board>.from(boards)
    ..sort((a, b) {
      final aTime = a.updatedAt ?? a.createdAt ?? DateTime(0);
      final bTime = b.updatedAt ?? b.createdAt ?? DateTime(0);
      return bTime.compareTo(aTime);
    });

  /// Search boards by name
  List<Board> searchBoards(String query) {
    final lowerQuery = query.toLowerCase();
    return boards
        .where((b) => b.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  // =========================================================================
  // For UI Efficiency
  // =========================================================================

  /// Check if state has changed since a version
  bool hasChangedSince(int sinceVersion) => version > sinceVersion;

  /// Get board state for a specific board (for list item rebuilds)
  BoardSummary? getBoardSummary(String boardId) {
    final board = boardsMap[boardId];
    if (board == null) return null;
    return BoardSummary(
      id: board.id,
      name: board.name,
      pinCount: board.pinCount,
      isPrivate: board.isPrivate,
      hasCoverImage: board.hasCoverImage,
      coverImageUrl: board.coverImageUrl,
    );
  }
}

/// Lightweight board summary for efficient list rendering
class BoardSummary {
  const BoardSummary({
    required this.id,
    required this.name,
    required this.pinCount,
    required this.isPrivate,
    required this.hasCoverImage,
    this.coverImageUrl,
  });

  final String id;
  final String name;
  final int pinCount;
  final bool isPrivate;
  final bool hasCoverImage;
  final String? coverImageUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardSummary &&
          id == other.id &&
          name == other.name &&
          pinCount == other.pinCount &&
          isPrivate == other.isPrivate &&
          coverImageUrl == other.coverImageUrl;

  @override
  int get hashCode => Object.hash(id, name, pinCount, isPrivate, coverImageUrl);
}

/// Cache data for persistence
@freezed
class CollectionsCacheData with _$CollectionsCacheData {
  const factory CollectionsCacheData({
    required List<Board> boards,
    required List<String> boardOrder,
    required List<String> recentBoardIds,
    String? selectedBoardId,
    required DateTime cachedAt,
  }) = _CollectionsCacheData;

  factory CollectionsCacheData.fromJson(Map<String, dynamic> json) =>
      _$CollectionsCacheDataFromJson(json);
}
