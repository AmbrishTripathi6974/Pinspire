// search_results_grid.dart
// Masonry grid for search results
// Reuses existing masonry grid patterns

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/shared/widgets/pinterest_refresh_indicator.dart';
import 'package:pinterest/features/home/presentation/widgets/feed_pin_tile.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_options_bottom_sheet.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_quick_action_overlay.dart';
import 'package:pinterest/features/home/presentation/widgets/save_to_nav_animation_overlay.dart';
import 'package:pinterest/features/search/presentation/providers/search_notifier.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

class SearchResultsGrid extends ConsumerStatefulWidget {
  const SearchResultsGrid({super.key});

  @override
  ConsumerState<SearchResultsGrid> createState() => _SearchResultsGridState();
}

class _SearchResultsGridState extends ConsumerState<SearchResultsGrid> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final hasMore = ref.read(searchHasMoreProvider);
    final isSearching = ref.read(searchIsSearchingProvider);

    if (!hasMore || isSearching) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= 300) {
      ref.read(searchProvider.notifier).loadMoreResults();
    }
  }

  void _showPinOptions(BuildContext context, Pin pin) {
    PinOptionsBottomSheet.show(
      context: context,
      pin: pin,
      inspirationText: 'This Pin is inspired by your search.',
      onSave: () {
        if (!pin.saved) {
          SaveToNavAnimationOverlay.show(
            context: context,
            imageUrl: pin.imageUrl,
            startPosition: null,
          );
        }
        ref.read(savedPinsProvider.notifier).toggleSavePin(
              pin,
              sourceQuery: ref.read(searchQueryProvider),
            );
      },
      onShare: () => _showFeedback(context, 'Share functionality coming soon'),
      onSeeMoreLikeThis: () => _showFeedback(context, "We'll show you more pins like this"),
      onSeeLessLikeThis: () => _showFeedback(context, "We'll show you fewer pins like this"),
      onReport: () => _showFeedback(context, 'Report submitted. Thank you!'),
    );
  }

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchResultsProvider);
    final isSearching = ref.watch(searchIsSearchingProvider);
    final hasMore = ref.watch(searchHasMoreProvider);
    final error = ref.watch(searchErrorProvider);
    final query = ref.watch(searchQueryProvider);

    if (results.isEmpty && isSearching) {
      return PinterestDotsLoader.centered();
    }

    if (results.isEmpty && !isSearching) {
      return _EmptyResults(query: query);
    }

    if (error != null && results.isEmpty) {
      return _ErrorState(
        error: error,
        onRetry: () => ref.read(searchProvider.notifier).search(query),
      );
    }

    return PinterestRefreshIndicator(
      onRefresh: () => ref.read(searchProvider.notifier).refreshSearchResults(),
      indicatorColor: const Color(0xFFE60023),
      child: MasonryGridView.count(
        controller: _scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: results.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == results.length) {
            return const _LoadingIndicator();
          }

          final pin = results[index];
          return FeedPinTile(
            key: ValueKey('search_pin_${pin.id}'),
            pin: pin,
            onTap: () => context.push(AppRoutes.pinViewerPath(pin.id)),
            onSave: () {
              if (!pin.saved && context.mounted) {
                SaveToNavAnimationOverlay.show(
                  context: context,
                  imageUrl: pin.imageUrl,
                  startPosition: null,
                );
              }
              ref.read(savedPinsProvider.notifier).toggleSavePin(
                    pin,
                    sourceQuery: ref.read(searchQueryProvider),
                  );
            },
            onSaveWithTouchPoint: (p, touchPoint) {
              if (!p.saved && context.mounted) {
                SaveToNavAnimationOverlay.show(
                  context: context,
                  imageUrl: p.imageUrl,
                  startPosition: touchPoint,
                );
              }
              ref.read(savedPinsProvider.notifier).toggleSavePin(
                    p,
                    sourceQuery: ref.read(searchQueryProvider),
                  );
            },
            onOptionsPressed: () => _showPinOptions(context, pin),
            actionContext: PinQuickActionContext.homeFeed,
            showSaveIconOnImage: true,
            borderRadius: 8.0,
          );
        },
      ),
    );
  }
}


class _EmptyResults extends StatelessWidget {
  const _EmptyResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Colors.grey.shade500 : Colors.grey.shade400;
    final titleColor = isDark ? Colors.grey.shade300 : Colors.grey.shade700;
    final subtitleColor = isDark ? Colors.grey.shade500 : Colors.grey.shade500;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 48,
              color: iconColor,
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching for something else',
              style: TextStyle(
                fontSize: 14,
                color: subtitleColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.error,
    required this.onRetry,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Colors.grey.shade500 : Colors.grey.shade400;
    final textColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.circleExclamation,
              size: 48,
              color: iconColor,
            ),
            const SizedBox(height: 16),
            Text(
              error,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onRetry,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: PinterestDotsLoader.compact(),
      ),
    );
  }
}
