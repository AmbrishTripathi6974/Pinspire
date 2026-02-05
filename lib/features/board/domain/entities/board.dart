// ignore_for_file: invalid_annotation_target

// Board domain entity with Freezed
// Core board representation for collections

import 'package:freezed_annotation/freezed_annotation.dart';

part 'board.freezed.dart';
part 'board.g.dart';

/// Represents a board/collection that contains saved pins
@freezed
class Board with _$Board {
  const Board._();

  const factory Board({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    @Default([]) List<String> pinIds,
    @Default(false) bool isPrivate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Board;

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  /// Number of pins in this board
  int get pinCount => pinIds.length;

  /// Whether the board is empty
  bool get isEmpty => pinIds.isEmpty;

  /// Whether the board has a cover image
  bool get hasCoverImage => coverImageUrl != null && coverImageUrl!.isNotEmpty;
}
