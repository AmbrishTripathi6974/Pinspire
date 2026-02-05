// saved_boards_tab.dart
// Boards tab: filter pills, user boards grid, Board suggestions, blue CTA, Unorganised ideas

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/features/board/domain/entities/board.dart';

/// Mock boards for Saved section (no backend).
final List<Board> _mockUserBoards = [
  Board(
    id: 'b1',
    name: 'Peace illustration',
    pinIds: List.generate(30, (i) => 'p$i'),
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Board(
    id: 'b2',
    name: 'God illustrations',
    pinIds: List.generate(5, (i) => 'p$i'),
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Board(
    id: 'b3',
    name: 'dresses',
    pinIds: List.generate(6, (i) => 'p$i'),
    createdAt: DateTime.now().subtract(const Duration(days: 21)),
  ),
  Board(
    id: 'b4',
    name: 'Study tips',
    pinIds: List.generate(3, (i) => 'p$i'),
    createdAt: DateTime.now().subtract(const Duration(days: 60)),
  ),
];

String _formatTimeAgo(DateTime? date) {
  if (date == null) return '';
  final diff = DateTime.now().difference(date);
  if (diff.inDays < 1) return '1d';
  if (diff.inDays < 7) return '${diff.inDays}d';
  if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w';
  if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo';
  return '${(diff.inDays / 365).floor()}y';
}

class SavedBoardsTab extends ConsumerWidget {
  const SavedBoardsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        // User boards grid (filter row is fixed in header)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final board = _mockUserBoards[index];
                return _SavedBoardCard(
                  name: board.name,
                  pinCount: board.pinCount,
                  timeAgo: _formatTimeAgo(board.createdAt),
                );
              },
              childCount: _mockUserBoards.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        // Board suggestions
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Board suggestions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _BoardSuggestionCard(isDark: isDark),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        // Unorganised ideas
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Unorganised ideas',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Material(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Text('Organise', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

class _SavedBoardCard extends StatelessWidget {
  const _SavedBoardCard({
    required this.name,
    required this.pinCount,
    required this.timeAgo,
  });

  final String name;
  final int pinCount;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final placeholderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: placeholderColor,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(4, (_) => Container(color: Colors.grey.shade400)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '$pinCount Pins $timeAgo',
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _BoardSuggestionCard extends StatelessWidget {
  const _BoardSuggestionCard({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: placeholderColor,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Material(
                    color: theme.colorScheme.surfaceContainerLowest.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Create', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
