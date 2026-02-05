// Search & Discover page
// Pinterest-style search screen with hero carousel, discovery sections

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';
import 'package:pinterest/features/search/presentation/providers/discover_notifier.dart';
import 'package:pinterest/features/search/presentation/providers/ideas_for_you_provider.dart';
import 'package:pinterest/features/search/presentation/providers/search_notifier.dart';
import 'package:pinterest/features/search/presentation/widgets/discover_search_bar.dart';
import 'package:pinterest/features/search/presentation/widgets/hero_carousel.dart';
import 'package:pinterest/features/search/presentation/widgets/idea_boards_section.dart';
import 'package:pinterest/features/search/presentation/widgets/popular_category_section.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/search/presentation/widgets/search_mode_content.dart';
import 'package:pinterest/shared/widgets/pinterest_refresh_indicator.dart';
import 'package:pinterest/features/search/presentation/widgets/search_results_grid.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onCategoryTap(DiscoverCategory category) {
    ref.read(searchProvider.notifier).search(category.query);
    ref.read(searchProvider.notifier).enterSearchMode();
  }

  void _onBoardTap(IdeaBoard board) {
    ref.read(searchProvider.notifier).search(board.title);
    ref.read(searchProvider.notifier).enterSearchMode();
  }

  void _onHeroTap(HeroItem item) {
    ref.read(searchProvider.notifier).search(item.headline);
    ref.read(searchProvider.notifier).enterSearchMode();
  }

  void _exitSearchMode() {
    ref.read(searchProvider.notifier).exitSearchMode();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isSearchMode = ref.watch(searchIsSearchModeProvider);
    final hasResults = ref.watch(searchResultsProvider).isNotEmpty;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: isSearchMode
          ? _SearchModeView(
              hasResults: hasResults,
              onBack: _exitSearchMode,
            )
          : _DiscoverView(
              scrollController: _scrollController,
              onCategoryTap: _onCategoryTap,
              onBoardTap: _onBoardTap,
              onHeroTap: _onHeroTap,
            ),
    );
  }
}

/// Discover mode - Hero carousel and discovery sections
class _DiscoverView extends ConsumerWidget {
  const _DiscoverView({
    required this.scrollController,
    required this.onCategoryTap,
    required this.onBoardTap,
    required this.onHeroTap,
  });

  final ScrollController scrollController;
  final void Function(DiscoverCategory) onCategoryTap;
  final void Function(IdeaBoard) onBoardTap;
  final void Function(HeroItem) onHeroTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(discoverIsLoadingProvider);
    final heroItems = ref.watch(discoverHeroItemsProvider);
    final ideaBoards = ref.watch(discoverIdeaBoardsProvider);
    final categories = ref.watch(discoverCategoriesProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    if (isLoading && heroItems.isEmpty) {
      return const _LoadingView();
    }

    return Stack(
      children: [
        // Scrollable content
        PinterestRefreshIndicator(
          onRefresh: () => ref.read(discoverProvider.notifier).refresh(),
          indicatorColor: const Color(0xFFE60023),
          edgeOffset: topPadding + 56,
          child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // Hero carousel (full bleed, behind search bar)
              SliverToBoxAdapter(
                child: HeroCarousel(
                  items: heroItems,
                  topPadding: topPadding,
                  onItemTap: onHeroTap,
                ),
              ),

              // Ideas you might like
              if (ideaBoards.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: IdeaBoardsSection(
                      boards: ideaBoards,
                      onBoardTap: onBoardTap,
                    ),
                  ),
                ),

              // Ideas for you (from saved pins by source search query)
              SliverToBoxAdapter(
                child: _IdeasForYouSection(onCategoryTap: onCategoryTap),
              ),

              // Popular categories
              if (categories.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: PopularCategoriesList(
                      categories: categories,
                      onCategoryTap: onCategoryTap,
                    ),
                  ),
                ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),

        // Floating search bar
        Positioned(
          top: topPadding + 8,
          left: 16,
          right: 16,
          child: const FloatingSearchBar(),
        ),
      ],
    );
  }
}

/// Search mode view with back button
class _SearchModeView extends ConsumerWidget {
  const _SearchModeView({
    required this.hasResults,
    required this.onBack,
  });

  final bool hasResults;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding = MediaQuery.of(context).padding.top;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Search bar with back button
        Container(
          color: theme.scaffoldBackgroundColor,
          padding: EdgeInsets.only(
            top: topPadding + 8,
            left: 4,
            right: 16,
            bottom: 8,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onBack,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    size: 20,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const Expanded(
                child: ActiveSearchBar(),
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: hasResults
              ? const SearchResultsGrid()
              : const SearchModeContent(),
        ),
      ],
    );
  }
}

/// Ideas for you section – watches provider so it rebuilds when saved pins / source queries change.
class _IdeasForYouSection extends ConsumerWidget {
  const _IdeasForYouSection({
    required this.onCategoryTap,
  });

  final void Function(DiscoverCategory) onCategoryTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasForYouCategories = ref.watch(ideasForYouCategoriesProvider);
    if (ideasForYouCategories.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: PopularCategoriesList(
        categories: ideasForYouCategories,
        onCategoryTap: onCategoryTap,
        sectionLabel: 'Ideas for you',
      ),
    );
  }
}

/// Loading state: search bar visible + Pinterest three-dots loader until data loads.
/// Smooth flow on app start/restart: first tap shows this, then content appears.
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        // Full-area background (scaffold color)
        Positioned.fill(
          child: ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        // Three-dots loading centered (Pinterest-style)
        const Center(
          child: PinterestDotsLoader(
            size: 40,
            dotSize: 8,
          ),
        ),
        // Same floating search bar as loaded state so UI is visible immediately
        Positioned(
          top: topPadding + 8,
          left: 16,
          right: 16,
          child: const FloatingSearchBar(),
        ),
      ],
    );
  }
}
