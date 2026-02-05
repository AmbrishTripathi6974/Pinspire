// Home feed page with Pinterest-style tabs
// Main feed page with "For You" and collection tabs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/utils/hero_tag_manager.dart';
import 'package:pinterest/core/widgets/loading/masonry_skeleton.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/home/presentation/providers/feed_provider.dart';
import 'package:pinterest/features/home/presentation/widgets/feed_pin_tile.dart';
import 'package:pinterest/features/home/presentation/widgets/masonry_grid.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_options_bottom_sheet.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_quick_action_overlay.dart';
import 'package:pinterest/features/home/presentation/widgets/save_to_nav_animation_overlay.dart';
import 'package:pinterest/shared/providers/app_providers.dart';
import 'package:pinterest/shared/widgets/pinterest_refresh_indicator.dart';

/// Home feed page with Pinterest-style tabs
/// 
/// Features:
/// - "For You" tab showing recent activity based pins
/// - Collection/Board tabs showing pins from saved collections
/// - Masonry grid layout
/// - Pull to refresh
/// - Infinite scroll pagination
/// - Three-dot menu for pin options
class HomeFeedPage extends ConsumerStatefulWidget {
  const HomeFeedPage({super.key});

  @override
  ConsumerState<HomeFeedPage> createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends ConsumerState<HomeFeedPage>
    with SingleTickerProviderStateMixin {
  final PreservingScrollController _scrollController = PreservingScrollController();
  late TabController _tabController;
  
  // Track selected board filter (null = For You tab)
  String? _selectedBoardId;

  @override
  void initState() {
    super.initState();
    // Initialize tab controller - will be updated when boards load
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(feedProvider.notifier).refresh();
    
    // After refresh, smoothly scroll to top to show new content
    if (mounted && _scrollController.hasClients) {
      // Use animateTo for smooth scroll, or jumpTo for instant
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onLoadMore() {
    ref.read(feedProvider.notifier).loadNextPage();
  }


  void _onSavePin(Pin pin) {
    ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
    ref.read(feedProvider.notifier).updatePinSaveState(
          pin.id,
          !pin.saved,
        );
  }

  /// Called when Save is tapped from quick action overlay (with touch point). Shows fly-to-saved animation then saves.
  void _onSavePinWithTouchPoint(Pin pin, Offset touchPoint) {
    if (!pin.saved) {
      SaveToNavAnimationOverlay.show(
        context: context,
        imageUrl: pin.imageUrl,
        startPosition: touchPoint,
      );
    }
    _onSavePin(pin);
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _onPinOptionsPressed(Pin pin) {
    PinOptionsBottomSheet.show(
      context: context,
      pin: pin,
      inspirationText: 'This Pin is inspired by your recent activity.',
      onSave: () {
        if (!pin.saved) {
          SaveToNavAnimationOverlay.show(
            context: context,
            imageUrl: pin.imageUrl,
            startPosition: null,
          );
        }
        _onSavePin(pin);
      },
      onShare: () => _showFeedback('Share functionality coming soon'),
      onSeeMoreLikeThis: () => _showFeedback("We'll show you more pins like this"),
      onSeeLessLikeThis: () => _showFeedback("We'll show you fewer pins like this"),
      onReport: () => _showFeedback('Report submitted. Thank you!'),
    );
  }

  void _onTabSelected(int index, List<Board> boards) {
    setState(() {
      if (index == 0) {
        _selectedBoardId = null; // "For You" tab
      } else if (index - 1 < boards.length) {
        _selectedBoardId = boards[index - 1].id;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use optimized providers with selective watching to minimize rebuilds
    final isInitialLoading = ref.watch(feedIsInitialLoadingProvider);
    final pinsWithSavedState = ref.watch(feedPinsWithSavedStateProvider);
    final hasMore = ref.watch(feedHasMoreProvider);
    final isLoadingMore = ref.watch(feedIsLoadingMoreProvider);
    final error = ref.watch(feedErrorProvider);
    final isEmpty = ref.watch(feedIsEmptyProvider);
    final boards = ref.watch(boardsListProvider);

    // Filter pins based on selected board
    final filteredPins = _filterPinsByBoard(pinsWithSavedState, boards);

    // Update tab controller when boards change - optimized to avoid unnecessary recreations
    final totalTabs = 1 + boards.length; // "For You" + board tabs
    if (_tabController.length != totalTabs) {
      final currentIndex = _tabController.index.clamp(0, totalTabs - 1);
      final oldController = _tabController;
      _tabController = TabController(
        length: totalTabs,
        vsync: this,
        initialIndex: currentIndex,
      );
      // Dispose old controller after creating new one to avoid state issues
      WidgetsBinding.instance.addPostFrameCallback((_) {
        oldController.dispose();
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top tabs
            _buildTabBar(boards),

            // Feed content
            Expanded(
              child: _buildBody(
                context: context,
                isInitialLoading: isInitialLoading,
                pins: filteredPins,
                hasMore: hasMore,
                isLoadingMore: isLoadingMore,
                error: error,
                isEmpty: isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Pin> _filterPinsByBoard(List<Pin> pins, List<Board> boards) {
    if (_selectedBoardId == null) {
      // "For You" tab - show all pins
      return pins;
    }

    // Find the selected board
    final selectedBoard = boards.firstWhere(
      (b) => b.id == _selectedBoardId,
      orElse: () => const Board(id: '', name: ''),
    );

    if (selectedBoard.id.isEmpty) {
      return pins;
    }

    // Filter pins that are in this board
    return pins.where((pin) => selectedBoard.pinIds.contains(pin.id)).toList();
  }

  Widget _buildTabBar(List<Board> boards) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 30,
      color: isDark ? Colors.black : Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        onTap: (index) => _onTabSelected(index, boards),
        tabAlignment: TabAlignment.start,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.zero,
        indicator: _RoundedUnderlineIndicator(
          color: isDark ? Colors.white : Colors.black,
          thickness: 2.5,
          radius: 1.5,
        ),
        dividerColor: Colors.transparent,
        labelColor: isDark ? Colors.white : Colors.black,
        unselectedLabelColor: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: [
          const Tab(text: 'For you'),
          ...boards.map((board) => Tab(text: board.name)),
        ],
      ),
    );
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
    if (isInitialLoading) {
      return const MasonrySkeleton();
    }

    if (error != null && pins.isEmpty) {
      return _ErrorState(
        message: error,
        onRetry: () => ref.read(feedProvider.notifier).retry(),
      );
    }

    if (isEmpty || pins.isEmpty) {
      return _EmptyState(
        onRefresh: _onRefresh,
        isForYouTab: _selectedBoardId == null,
      );
    }

    return ShimmerProvider(
      child: PinterestRefreshIndicator(
        onRefresh: _onRefresh,
        child: _HomeMasonryPinGrid(
          pins: pins,
          onLoadMore: _onLoadMore,
          hasMore: hasMore,
          isLoadingMore: isLoadingMore,
          scrollController: _scrollController,
          onPinTap: (pin, index) {
            // Generate Hero tag matching the feed tile with index
            final heroTag = HeroTagManager.generateTag(
              pinId: pin.id,
              context: HeroTagContext.homeFeed,
              index: index,
            );
            context.push(AppRoutes.pinViewerPath(pin.id, heroTag: heroTag));
          },
          onSavePin: _onSavePin,
          onSavePinWithTouchPoint: _onSavePinWithTouchPoint,
          onPinOptionsPressed: _onPinOptionsPressed,
        ),
      ),
    );
  }
}

/// Custom masonry grid with options button support
class _HomeMasonryPinGrid extends StatefulWidget {
  const _HomeMasonryPinGrid({
    required this.pins,
    required this.onLoadMore,
    required this.hasMore,
    this.isLoadingMore = false,
    this.onPinTap,
    this.onSavePin,
    this.onSavePinWithTouchPoint,
    this.onPinOptionsPressed,
    this.scrollController,
  });

  static const int _crossAxisCount = 2;
  static const double _mainAxisSpacing = 8.0;
  static const double _crossAxisSpacing = 8.0;
  static const EdgeInsets _padding = EdgeInsets.all(8.0);
  static const double _loadMoreThreshold = 200.0;

  final List<Pin> pins;
  final VoidCallback onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;
  final void Function(Pin pin, int index)? onPinTap;
  final void Function(Pin pin)? onSavePin;
  /// When Save is tapped from quick action overlay, called with (pin, touchPoint) before [onSavePin] (e.g. for fly-to-saved animation).
  final void Function(Pin pin, Offset touchPoint)? onSavePinWithTouchPoint;
  final void Function(Pin pin)? onPinOptionsPressed;
  final ScrollController? scrollController;

  @override
  State<_HomeMasonryPinGrid> createState() => _HomeMasonryPinGridState();
}

class _HomeMasonryPinGridState extends State<_HomeMasonryPinGrid> {
  late ScrollController _scrollController;
  bool _isInternalController = false;
  Timer? _debounceTimer;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _initScrollController();
  }

  void _initScrollController() {
    if (widget.scrollController != null) {
      _scrollController = widget.scrollController!;
      _isInternalController = false;
    } else {
      _scrollController = ScrollController();
      _isInternalController = true;
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(_HomeMasonryPinGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      _scrollController.removeListener(_onScroll);
      if (_isInternalController) {
        _scrollController.dispose();
      }
      _initScrollController();
    }
    
    // Update loading state
    if (widget.isLoadingMore != oldWidget.isLoadingMore) {
      _isLoadingMore = widget.isLoadingMore;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    if (_isInternalController) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    // Debounce scroll events to avoid excessive calls
    _debounceTimer?.cancel();
    
    if (!widget.hasMore || widget.isLoadingMore || _isLoadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _HomeMasonryPinGrid._loadMoreThreshold) {
      // Debounce load more calls to prevent rapid-fire requests
      _debounceTimer = Timer(const Duration(milliseconds: 150), () {
        if (mounted && !_isLoadingMore && widget.hasMore) {
          _isLoadingMore = true;
          widget.onLoadMore();
          // Reset flag after a delay to allow for loading state updates
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              _isLoadingMore = false;
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pins.isEmpty) {
      return const SizedBox.shrink();
    }

    return MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: _HomeMasonryPinGrid._crossAxisCount,
      mainAxisSpacing: _HomeMasonryPinGrid._mainAxisSpacing,
      crossAxisSpacing: _HomeMasonryPinGrid._crossAxisSpacing,
      padding: _HomeMasonryPinGrid._padding,
      // Enable overscroll for pull-to-refresh on all platforms
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      cacheExtent: 700,
      addRepaintBoundaries: false,
      addAutomaticKeepAlives: false,
      itemCount: widget.pins.length + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= widget.pins.length) {
          return _buildLoadingIndicator();
        }

        final pin = widget.pins[index];
        return FeedPinTile(
          key: ValueKey('pin_${pin.id}_$index'),
          pin: pin,
          heroTagContext: HeroTagContext.homeFeed,
          heroTagIndex: index,
          onTap: widget.onPinTap != null ? () => widget.onPinTap!(pin, index) : null,
          onSave: widget.onSavePin != null
              ? () {
                  if (!pin.saved && context.mounted) {
                    SaveToNavAnimationOverlay.show(
                      context: context,
                      imageUrl: pin.imageUrl,
                      startPosition: null,
                    );
                  }
                  widget.onSavePin!(pin);
                }
              : null,
          onSaveWithTouchPoint: widget.onSavePinWithTouchPoint,
          onOptionsPressed: widget.onPinOptionsPressed != null
              ? () => widget.onPinOptionsPressed!(pin)
              : null,
          actionContext: PinQuickActionContext.homeFeed,
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: widget.isLoadingMore
            ? const PinterestDotsLoader.compact()
            : const SizedBox.shrink(),
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
            Icon(
              Icons.cloud_download_outlined,
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
              icon: const Icon(Icons.refresh, size: 16),
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
    this.isForYouTab = true,
  });

  final Future<void> Function() onRefresh;
  final bool isForYouTab;

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
                    Icon(
                      isForYouTab ? Icons.explore_outlined : Icons.collections_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isForYouTab ? 'No pins yet' : 'No pins in this collection',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isForYouTab
                          ? 'Pull down to refresh and discover new content'
                          : 'Save some pins to this collection to see them here',
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

/// Custom rounded underline indicator for TabBar
/// Creates a pill/capsule shaped indicator at the bottom of the tab
class _RoundedUnderlineIndicator extends Decoration {
  const _RoundedUnderlineIndicator({
    required this.color,
    this.thickness = 3,
    this.radius = 1.5,
  });

  final Color color;
  final double thickness;
  final double radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _RoundedUnderlinePainter(
      color: color,
      thickness: thickness,
      radius: radius,
    );
  }
}

class _RoundedUnderlinePainter extends BoxPainter {
  _RoundedUnderlinePainter({
    required this.color,
    required this.thickness,
    required this.radius,
  });

  final Color color;
  final double thickness;
  final double radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx,
        offset.dy + configuration.size!.height - thickness,
        configuration.size!.width,
        thickness,
      ),
      Radius.circular(radius),
    );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rect, paint);
  }
}
