// Collections StateNotifier with SharedPreferences persistence
// Manages boards/collections state with automatic persistence

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/board/domain/entities/board.dart';
import 'package:pinterest/shared/state/collections_state.dart';

/// StateNotifier for boards/collections
///
/// Features:
/// - Automatic persistence to SharedPreferences as JSON
/// - Pin-to-board reverse mapping for quick queries
/// - Version tracking for efficient UI rebuilds
/// - Recent boards tracking
/// - Batch operations for performance
class CollectionsNotifier extends StateNotifier<CollectionsState> {
  CollectionsNotifier({
    required LocalStorageService localStorage,
  })  : _localStorage = localStorage,
        super(const CollectionsState()) {
    _loadPersistedState();
  }

  final LocalStorageService _localStorage;

  /// Maximum number of recent boards to track
  static const _maxRecentBoards = 5;

  // =========================================================================
  // Initialization & Persistence
  // =========================================================================

  /// Loads persisted state from SharedPreferences
  Future<void> _loadPersistedState() async {
    state = state.copyWith(isLoading: true);

    try {
      final cacheJson = _localStorage.getJson(StorageKeys.collectionsCache);

      if (cacheJson != null) {
        final cacheData = CollectionsCacheData.fromJson(cacheJson);

        // Build boards map and pin-to-boards map
        final boardsMap = <String, Board>{};
        final pinToBoardsMap = <String, Set<String>>{};

        for (final board in cacheData.boards) {
          boardsMap[board.id] = board;

          // Build reverse mapping
          for (final pinId in board.pinIds) {
            pinToBoardsMap.putIfAbsent(pinId, () => {}).add(board.id);
          }
        }

        state = state.copyWith(
          boardsMap: boardsMap,
          boardOrder: cacheData.boardOrder,
          pinToBoardsMap: pinToBoardsMap,
          selectedBoardId: cacheData.selectedBoardId,
          recentBoardIds: cacheData.recentBoardIds,
          isLoading: false,
          isInitialized: true,
          lastUpdated: cacheData.cachedAt,
          error: null,
        );
      } else {
        // Fallback: Load from legacy format
        final boardsJson = _localStorage.getJsonList(StorageKeys.collections);
        final boards =
            boardsJson?.map((json) => Board.fromJson(json)).toList() ?? [];
        final selectedBoardId =
            _localStorage.getString(StorageKeys.lastSelectedBoardId);

        // Build maps
        final boardsMap = <String, Board>{};
        final boardOrder = <String>[];
        final pinToBoardsMap = <String, Set<String>>{};

        for (final board in boards) {
          boardsMap[board.id] = board;
          boardOrder.add(board.id);

          for (final pinId in board.pinIds) {
            pinToBoardsMap.putIfAbsent(pinId, () => {}).add(board.id);
          }
        }

        state = state.copyWith(
          boardsMap: boardsMap,
          boardOrder: boardOrder,
          pinToBoardsMap: pinToBoardsMap,
          selectedBoardId: selectedBoardId,
          isLoading: false,
          isInitialized: true,
          error: null,
        );

        // Migrate to new format
        await _persistState();
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        error: 'Failed to load collections',
      );
    }
  }

  /// Persists current state to SharedPreferences
  Future<void> _persistState() async {
    try {
      final cacheData = CollectionsCacheData(
        boards: state.boards,
        boardOrder: state.boardOrder,
        recentBoardIds: state.recentBoardIds,
        selectedBoardId: state.selectedBoardId,
        cachedAt: DateTime.now(),
      );

      await _localStorage.setJson(
        StorageKeys.collectionsCache,
        cacheData.toJson(),
      );

      // Also save selected board separately for quick access
      if (state.selectedBoardId != null) {
        await _localStorage.setString(
          StorageKeys.lastSelectedBoardId,
          state.selectedBoardId!,
        );
      } else {
        await _localStorage.remove(StorageKeys.lastSelectedBoardId);
      }
    } catch (_) {
      // Silently fail
    }
  }

  /// Increments version for efficient UI updates
  void _incrementVersion() {
    state = state.copyWith(
      version: state.version + 1,
      lastUpdated: DateTime.now(),
    );
  }

  /// Updates pin-to-boards map when a board's pins change
  Map<String, Set<String>> _rebuildPinToBoardsMap() {
    final pinToBoardsMap = <String, Set<String>>{};

    for (final board in state.boards) {
      for (final pinId in board.pinIds) {
        pinToBoardsMap.putIfAbsent(pinId, () => {}).add(board.id);
      }
    }

    return pinToBoardsMap;
  }

  /// Adds a board to recent boards
  List<String> _addToRecentBoards(String boardId) {
    final recent = List<String>.from(state.recentBoardIds);
    recent.remove(boardId);
    recent.insert(0, boardId);
    if (recent.length > _maxRecentBoards) {
      recent.removeLast();
    }
    return recent;
  }

  // =========================================================================
  // Board CRUD Operations
  // =========================================================================

  /// Creates a new board
  Future<Board> createBoard({
    required String name,
    String? description,
    String? coverImageUrl,
    bool isPrivate = false,
  }) async {
    final newBoard = Board(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      coverImageUrl: coverImageUrl,
      isPrivate: isPrivate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final newBoardsMap = Map<String, Board>.from(state.boardsMap);
    newBoardsMap[newBoard.id] = newBoard;

    state = state.copyWith(
      boardsMap: newBoardsMap,
      boardOrder: [...state.boardOrder, newBoard.id],
      recentBoardIds: _addToRecentBoards(newBoard.id),
    );

    _incrementVersion();
    await _persistState();

    return newBoard;
  }

  /// Updates an existing board
  Future<void> updateBoard(Board updatedBoard) async {
    if (!state.boardsMap.containsKey(updatedBoard.id)) return;

    final oldBoard = state.boardsMap[updatedBoard.id]!;
    final newBoardsMap = Map<String, Board>.from(state.boardsMap);
    newBoardsMap[updatedBoard.id] = updatedBoard.copyWith(
      updatedAt: DateTime.now(),
    );

    // Rebuild pin mapping if pins changed
    final pinsChanged = oldBoard.pinIds.length != updatedBoard.pinIds.length ||
        !oldBoard.pinIds.toSet().containsAll(updatedBoard.pinIds);

    state = state.copyWith(
      boardsMap: newBoardsMap,
      pinToBoardsMap:
          pinsChanged ? _rebuildPinToBoardsMap() : state.pinToBoardsMap,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Renames a board
  Future<void> renameBoard(String boardId, String newName) async {
    final board = state.boardsMap[boardId];
    if (board == null) return;

    await updateBoard(board.copyWith(name: newName));
  }

  /// Deletes a board
  Future<void> deleteBoard(String boardId) async {
    if (!state.boardsMap.containsKey(boardId)) return;

    final newBoardsMap = Map<String, Board>.from(state.boardsMap);
    newBoardsMap.remove(boardId);

    final newBoardOrder = state.boardOrder.where((id) => id != boardId).toList();
    final newRecentIds =
        state.recentBoardIds.where((id) => id != boardId).toList();

    state = state.copyWith(
      boardsMap: newBoardsMap,
      boardOrder: newBoardOrder,
      recentBoardIds: newRecentIds,
      pinToBoardsMap: _rebuildPinToBoardsMap(),
      selectedBoardId:
          state.selectedBoardId == boardId ? null : state.selectedBoardId,
    );

    _incrementVersion();
    await _persistState();
  }

  // =========================================================================
  // Pin-Board Operations
  // =========================================================================

  /// Adds a pin to a board
  Future<void> addPinToBoard({
    required String boardId,
    required String pinId,
  }) async {
    final board = state.boardsMap[boardId];
    if (board == null) return;
    if (board.pinIds.contains(pinId)) return;

    final updatedBoard = board.copyWith(
      pinIds: [...board.pinIds, pinId],
      updatedAt: DateTime.now(),
    );

    final newBoardsMap = Map<String, Board>.from(state.boardsMap);
    newBoardsMap[boardId] = updatedBoard;

    // Update pin-to-boards map
    final newPinToBoardsMap =
        Map<String, Set<String>>.from(state.pinToBoardsMap);
    newPinToBoardsMap.putIfAbsent(pinId, () => {}).add(boardId);

    state = state.copyWith(
      boardsMap: newBoardsMap,
      pinToBoardsMap: newPinToBoardsMap,
      recentBoardIds: _addToRecentBoards(boardId),
    );

    _incrementVersion();
    await _persistState();
  }

  /// Removes a pin from a board
  Future<void> removePinFromBoard({
    required String boardId,
    required String pinId,
  }) async {
    final board = state.boardsMap[boardId];
    if (board == null) return;
    if (!board.pinIds.contains(pinId)) return;

    final updatedBoard = board.copyWith(
      pinIds: board.pinIds.where((id) => id != pinId).toList(),
      updatedAt: DateTime.now(),
    );

    final newBoardsMap = Map<String, Board>.from(state.boardsMap);
    newBoardsMap[boardId] = updatedBoard;

    // Update pin-to-boards map
    final newPinToBoardsMap =
        Map<String, Set<String>>.from(state.pinToBoardsMap);
    newPinToBoardsMap[pinId]?.remove(boardId);
    if (newPinToBoardsMap[pinId]?.isEmpty ?? false) {
      newPinToBoardsMap.remove(pinId);
    }

    state = state.copyWith(
      boardsMap: newBoardsMap,
      pinToBoardsMap: newPinToBoardsMap,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Moves a pin from one board to another
  Future<void> movePinToBoard({
    required String pinId,
    required String fromBoardId,
    required String toBoardId,
  }) async {
    if (fromBoardId == toBoardId) return;

    await removePinFromBoard(boardId: fromBoardId, pinId: pinId);
    await addPinToBoard(boardId: toBoardId, pinId: pinId);
  }

  /// Copies a pin to another board
  Future<void> copyPinToBoard({
    required String pinId,
    required String toBoardId,
  }) async {
    await addPinToBoard(boardId: toBoardId, pinId: pinId);
  }

  /// Batch add pins to a board
  Future<void> addPinsToBoard({
    required String boardId,
    required List<String> pinIds,
  }) async {
    final board = state.boardsMap[boardId];
    if (board == null) return;

    final existingPinIds = board.pinIds.toSet();
    final newPinIds = pinIds.where((id) => !existingPinIds.contains(id)).toList();
    if (newPinIds.isEmpty) return;

    final updatedBoard = board.copyWith(
      pinIds: [...board.pinIds, ...newPinIds],
      updatedAt: DateTime.now(),
    );

    final newBoardsMap = Map<String, Board>.from(state.boardsMap);
    newBoardsMap[boardId] = updatedBoard;

    // Update pin-to-boards map
    final newPinToBoardsMap =
        Map<String, Set<String>>.from(state.pinToBoardsMap);
    for (final pinId in newPinIds) {
      newPinToBoardsMap.putIfAbsent(pinId, () => {}).add(boardId);
    }

    state = state.copyWith(
      boardsMap: newBoardsMap,
      pinToBoardsMap: newPinToBoardsMap,
      recentBoardIds: _addToRecentBoards(boardId),
    );

    _incrementVersion();
    await _persistState();
  }

  /// Sets cover image for a board (usually the first pin's image)
  Future<void> setBoardCover(String boardId, String? coverImageUrl) async {
    final board = state.boardsMap[boardId];
    if (board == null) return;

    await updateBoard(board.copyWith(coverImageUrl: coverImageUrl));
  }

  // =========================================================================
  // Selection & Navigation
  // =========================================================================

  /// Selects a board
  Future<void> selectBoard(String? boardId) async {
    state = state.copyWith(
      selectedBoardId: boardId,
      recentBoardIds:
          boardId != null ? _addToRecentBoards(boardId) : state.recentBoardIds,
    );

    _incrementVersion();
    await _persistState();
  }

  /// Clears selection
  void clearSelection() {
    state = state.copyWith(selectedBoardId: null);
  }

  // =========================================================================
  // Reordering
  // =========================================================================

  /// Reorders boards
  Future<void> reorderBoards(int oldIndex, int newIndex) async {
    if (oldIndex == newIndex) return;

    final newBoardOrder = List<String>.from(state.boardOrder);
    final boardId = newBoardOrder.removeAt(oldIndex);
    newBoardOrder.insert(newIndex, boardId);

    state = state.copyWith(boardOrder: newBoardOrder);

    _incrementVersion();
    await _persistState();
  }

  /// Reorders pins within a board
  Future<void> reorderPinsInBoard({
    required String boardId,
    required int oldIndex,
    required int newIndex,
  }) async {
    final board = state.boardsMap[boardId];
    if (board == null) return;
    if (oldIndex == newIndex) return;

    final newPinIds = List<String>.from(board.pinIds);
    final pinId = newPinIds.removeAt(oldIndex);
    newPinIds.insert(newIndex, pinId);

    final updatedBoard = board.copyWith(
      pinIds: newPinIds,
      updatedAt: DateTime.now(),
    );

    final newBoardsMap = Map<String, Board>.from(state.boardsMap);
    newBoardsMap[boardId] = updatedBoard;

    state = state.copyWith(boardsMap: newBoardsMap);

    _incrementVersion();
    await _persistState();
  }

  // =========================================================================
  // Utility
  // =========================================================================

  /// Clears any error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Clears all collections data
  Future<void> clearAll() async {
    state = state.copyWith(
      boardsMap: {},
      boardOrder: [],
      pinToBoardsMap: {},
      selectedBoardId: null,
      recentBoardIds: [],
    );

    _incrementVersion();
    await _persistState();
  }
}
