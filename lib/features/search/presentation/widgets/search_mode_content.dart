// Search mode content widget
// Shows suggestions, recent searches, and trending when in search mode

import 'package:flutter/material.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';
import 'package:pinterest/features/search/presentation/providers/search_notifier.dart';

class SearchModeContent extends ConsumerWidget {
  const SearchModeContent({
    super.key,
    this.onSearchSelected,
  });

  final void Function(String query)? onSearchSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final suggestions = ref.watch(searchSuggestionsProvider);
    final recentSearches = ref.watch(searchRecentSearchesProvider);
    final trendingSearches = ref.watch(searchTrendingSearchesProvider);

    // Show suggestions if user is typing
    if (query.isNotEmpty && suggestions.isNotEmpty) {
      return _SuggestionsList(
        suggestions: suggestions,
        onSuggestionTap: (suggestion) {
          ref.read(searchProvider.notifier).search(suggestion);
          onSearchSelected?.call(suggestion);
        },
      );
    }

    // Show recent and trending when not typing
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recentSearches.isNotEmpty) ...[
            _RecentSearchesSection(
              searches: recentSearches,
              onSearchTap: (search) {
                ref.read(searchProvider.notifier).search(search.query);
                onSearchSelected?.call(search.query);
              },
              onRemove: (search) {
                ref.read(searchProvider.notifier).removeRecentSearch(search.query);
              },
              onClearAll: () {
                ref.read(searchProvider.notifier).clearRecentSearches();
              },
            ),
            const SizedBox(height: 24),
          ],
          if (trendingSearches.isNotEmpty)
            _TrendingSearchesSection(
              searches: trendingSearches,
              onSearchTap: (search) {
                ref.read(searchProvider.notifier).search(search.query);
                onSearchSelected?.call(search.query);
              },
            ),
          const SizedBox(height: 100), // Bottom padding
        ],
      ),
    );
  }
}

class _SuggestionsList extends StatelessWidget {
  const _SuggestionsList({
    required this.suggestions,
    required this.onSuggestionTap,
  });

  final List<String> suggestions;
  final void Function(String) onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return _SuggestionTile(
          suggestion: suggestion,
          onTap: () => onSuggestionTap(suggestion),
        );
      },
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({
    required this.suggestion,
    required this.onTap,
  });

  final String suggestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final arrowColor = isDark ? Colors.grey.shade500 : Colors.grey.shade400;
    final textColor = isDark ? Colors.white : Colors.black;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: iconColor,
              size: 16,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                suggestion,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
            FaIcon(
              FontAwesomeIcons.arrowUpLong,
              color: arrowColor,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentSearchesSection extends StatelessWidget {
  const _RecentSearchesSection({
    required this.searches,
    required this.onSearchTap,
    required this.onRemove,
    required this.onClearAll,
  });

  final List<RecentSearch> searches;
  final void Function(RecentSearch) onSearchTap;
  final void Function(RecentSearch) onRemove;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black;
    final clearAllColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              GestureDetector(
                onTap: onClearAll,
                child: Text(
                  'Clear all',
                  style: TextStyle(
                    fontSize: 14,
                    color: clearAllColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...searches.take(5).map((search) {
          return _RecentSearchTile(
            search: search,
            onTap: () => onSearchTap(search),
            onRemove: () => onRemove(search),
          );
        }),
      ],
    );
  }
}

class _RecentSearchTile extends StatelessWidget {
  const _RecentSearchTile({
    required this.search,
    required this.onTap,
    required this.onRemove,
  });

  final RecentSearch search;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final circleBgColor = isDark ? Colors.grey.shade800 : Colors.grey.shade100;
    final iconColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final textColor = isDark ? Colors.white : Colors.black;
    final closeColor = isDark ? Colors.grey.shade500 : Colors.grey.shade500;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: circleBgColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.clockRotateLeft,
                  color: iconColor,
                  size: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                search.query,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FaIcon(
                  FontAwesomeIcons.xmark,
                  color: closeColor,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendingSearchesSection extends StatelessWidget {
  const _TrendingSearchesSection({
    required this.searches,
    required this.onSearchTap,
  });

  final List<TrendingSearch> searches;
  final void Function(TrendingSearch) onSearchTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Trending searches',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...searches.map((search) {
          return _TrendingSearchTile(
            search: search,
            onTap: () => onSearchTap(search),
          );
        }),
      ],
    );
  }
}

class _TrendingSearchTile extends StatelessWidget {
  const _TrendingSearchTile({
    required this.search,
    required this.onTap,
  });

  final TrendingSearch search;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final placeholderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final iconColor = isDark ? Colors.grey.shade500 : Colors.grey.shade500;
    final textColor = isDark ? Colors.white : Colors.black;
    final trendIconColor = isDark ? Colors.grey.shade500 : Colors.grey.shade400;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: search.imageUrl.isNotEmpty
                  ? PinterestCachedImage(
                      imageUrl: search.imageUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(8),
                      placeholder: (_, __) => Container(
                        width: 48,
                        height: 48,
                        color: placeholderColor,
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: 48,
                        height: 48,
                        color: placeholderColor,
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.arrowTrendUp,
                            color: iconColor,
                            size: 16,
                          ),
                        ),
                      ),
                      memCacheWidth: 96,
                      memCacheHeight: 96,
                    )
                  : Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: placeholderColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.arrowTrendUp,
                          color: iconColor,
                          size: 16,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            // Query text
            Expanded(
              child: Text(
                search.query,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            // Trending indicator
            FaIcon(
              FontAwesomeIcons.arrowTrendUp,
              color: trendIconColor,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
