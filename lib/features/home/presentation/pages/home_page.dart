// Home page UI
// Main feed page with Pinterest-style masonry grid

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/home/presentation/providers/feed_provider.dart';
import 'package:pinterest/features/home/presentation/widgets/feed_pin_tile.dart';
import 'package:pinterest/features/home/presentation/widgets/masonry_grid.dart';
import 'package:pinterest/shared/providers/app_providers.dart';
import 'package:pinterest/shared/widgets/pinterest_refresh_indicator.dart';

/// Home page with Pinterest-style feed
///
/// Features:
/// - Custom pull-to-refresh animation
/// - Masonry grid layout
/// - Infinite scroll pagination
/// - Error handling with retry
/// - Empty state
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PreservingScrollController _scrollController = PreservingScrollController();

  // Memoization cache for synced pins
  List<Pin>? _cachedPins;
  Set<String>? _cachedSavedIds;
  List<Pin>? _syncedPins;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Memoized sync to avoid list recreation on every build
  List<Pin> _getSyncedPins(List<Pin> pins, Set<String> savedPinIds) {
    // Return cached result if inputs haven't changed
    if (identical(pins, _cachedPins) && 
        _setEquals(savedPinIds, _cachedSavedIds) &&
        _syncedPins != null) {
      return _syncedPins!;
    }
    
    // Cache miss - compute and store
    _cachedPins = pins;
    _cachedSavedIds = savedPinIds;
    _syncedPins = _syncSavedState(pins, savedPinIds);
    return _syncedPins!;
  }

  bool _setEquals(Set<String>? a, Set<String>? b) {
    if (a == null || b == null) return a == b;
    if (a.length != b.length) return false;
    return a.containsAll(b);
  }

  Future<void> _onRefresh() async {
    // Save scroll position before refresh
    _scrollController.saveOffset();

    await ref.read(feedProvider.notifier).refresh();

    // Restore scroll position after a brief delay
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      _scrollController.restoreOffset();
    }
  }

  void _onLoadMore() {
    ref.read(feedProvider.notifier).loadNextPage();
  }

  void _onPinTap(Pin pin) {
    context.push(AppRoutes.pinViewerPath(pin.id));
  }

  void _onSavePin(Pin pin) {
    ref.read(savedPinsProvider.notifier).toggleSavePin(pin);

    // Update feed state to reflect save change
    ref.read(feedProvider.notifier).updatePinSaveState(
          pin.id,
          !pin.saved,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isInitialLoading = ref.watch(feedIsInitialLoadingProvider);
    final pins = ref.watch(feedPinsProvider);
    final hasMore = ref.watch(feedHasMoreProvider);
    final isLoadingMore = ref.watch(feedIsLoadingMoreProvider);
    final error = ref.watch(feedErrorProvider);
    final isEmpty = ref.watch(feedIsEmptyProvider);

    // Sync saved state with pins (memoized to prevent unnecessary allocations)
    final savedPinIds = ref.watch(savedPinsProvider.select((s) => s.savedPinIds));
    final pinsWithSavedState = _getSyncedPins(pins, savedPinIds);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinterest'),
        actions: [
          // User button with sign-out functionality
          // Wrapped in SizedBox to prevent infinite width constraints
          const SizedBox(
            width: 48,
            height: 48,
            child: ClerkUserButton(),
          ),
        ],
      ),
      body: SafeArea(
        top: false, // AppBar handles top safe area
        child: _buildBody(
          context: context,
          isInitialLoading: isInitialLoading,
          pins: pinsWithSavedState,
          hasMore: hasMore,
          isLoadingMore: isLoadingMore,
          error: error,
          isEmpty: isEmpty,
        ),
      ),
    );
  }

  List<Pin> _syncSavedState(List<Pin> pins, Set<String> savedPinIds) {
    return pins.map((pin) {
      final isSaved = savedPinIds.contains(pin.id);
      if (pin.saved != isSaved) {
        return pin.copyWith(saved: isSaved);
      }
      return pin;
    }).toList();
  }

  Widget _buildBody({
    required BuildContext context,
    required bool isInitialLoading,
    required List<Pin> pins,
    required bool hasMore,
    required bool isLoadingMore,
    required String? error,
    required bool isEmpty,
  }) {
    // Initial loading state
    if (isInitialLoading) {
      return const _LoadingState();
    }

    // Error state (only when no content)
    if (error != null && pins.isEmpty) {
      return _ErrorState(
        message: error,
        onRetry: () => ref.read(feedProvider.notifier).retry(),
      );
    }

    // Empty state
    if (isEmpty) {
      return _EmptyState(
        onRefresh: _onRefresh,
      );
    }

    // Content with pull-to-refresh
    // ShimmerProvider shares one animation controller across all shimmer effects
    return ShimmerProvider(
      child: PinterestRefreshIndicator(
        onRefresh: _onRefresh,
        child: MasonryPinGrid(
          pins: pins,
          onLoadMore: _onLoadMore,
          hasMore: hasMore,
          isLoadingMore: isLoadingMore,
          scrollController: _scrollController,
          onPinTap: _onPinTap,
          onSavePin: _onSavePin,
        ),
      ),
    );
  }
}

/// Loading state widget
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PinterestDotsLoader(),
          const SizedBox(height: 16),
          Text(
            'Loading your feed...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Error state widget
class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.cloudArrowDown,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const FaIcon(FontAwesomeIcons.arrowsRotate, size: 16),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state widget
class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.onRefresh,
  });

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PinterestRefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.compass,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No pins yet',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pull down to refresh and discover new content',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Alternative home page using CustomScrollView for more control
class HomePageSliver extends ConsumerStatefulWidget {
  const HomePageSliver({super.key});

  @override
  ConsumerState<HomePageSliver> createState() => _HomePageSliverState();
}

class _HomePageSliverState extends ConsumerState<HomePageSliver> {
  final ScrollController _scrollController = ScrollController();

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
    final hasMore = ref.read(feedHasMoreProvider);
    final isLoadingMore = ref.read(feedIsLoadingMoreProvider);

    if (!hasMore || isLoadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= 200) {
      ref.read(feedProvider.notifier).loadNextPage();
    }
  }

  Future<void> _onRefresh() async {
    await ref.read(feedProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final isInitialLoading = ref.watch(feedIsInitialLoadingProvider);
    final pins = ref.watch(feedPinsProvider);
    final hasMore = ref.watch(feedHasMoreProvider);
    final isLoadingMore = ref.watch(feedIsLoadingMoreProvider);

    if (isInitialLoading) {
      return const Scaffold(body: _LoadingState());
    }

    return Scaffold(
      body: SafeArea(
        child: PinterestRefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // App bar (optional)
              const SliverAppBar(
                floating: true,
                title: Text('Home'),
              ),

              // Masonry grid
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverMasonryPinGrid(
                  pins: pins,
                  onPinTap: (pin) {
                    // Navigate to pin detail
                  },
                  onSavePin: (pin) {
                    ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
                  },
                ),
              ),

              // Loading indicator
              if (hasMore)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: isLoadingMore
                          ? const PinterestDotsLoader.compact()
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
