// Pinterest-style masonry grid widget
// Staggered grid layout for variable height pins

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/home/presentation/widgets/feed_pin_tile.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_quick_action_overlay.dart';

/// Pinterest-style masonry grid for displaying pins
///
/// Features:
/// - Staggered layout with variable heights
/// - Infinite scroll pagination
/// - Smooth scroll physics
/// - Loading indicator at bottom
/// - Maintains scroll position
class MasonryPinGrid extends StatefulWidget {
  const MasonryPinGrid({
    super.key,
    required this.pins,
    required this.onLoadMore,
    required this.hasMore,
    this.isLoadingMore = false,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.padding = const EdgeInsets.all(8.0),
    this.onPinTap,
    this.onPinLongPress,
    this.onSavePin,
    this.onPinOptionsPressed,
    this.showSaveIconOnImage = false,
    this.scrollController,
    this.loadMoreThreshold = 200.0,
    this.actionContext,
  });

  /// List of pins to display
  final List<Pin> pins;

  /// Callback when more items should be loaded
  final VoidCallback onLoadMore;

  /// Whether there are more items to load
  final bool hasMore;

  /// Whether more items are currently loading
  final bool isLoadingMore;

  /// Number of columns
  final int crossAxisCount;

  /// Spacing between rows
  final double mainAxisSpacing;

  /// Spacing between columns
  final double crossAxisSpacing;

  /// Padding around the grid
  final EdgeInsets padding;

  /// Callback when a pin is tapped
  final void Function(Pin pin)? onPinTap;

  /// Callback when a pin is long pressed
  final void Function(Pin pin)? onPinLongPress;

  /// Callback when save button is pressed
  final void Function(Pin pin)? onSavePin;

  /// Callback when options (more) button is pressed
  final void Function(Pin pin)? onPinOptionsPressed;

  /// When true, shows the save (pin) icon on the image (search-style card)
  final bool showSaveIconOnImage;

  /// Optional scroll controller
  final ScrollController? scrollController;

  /// Distance from bottom to trigger load more
  final double loadMoreThreshold;

  /// Context for quick action overlay
  final PinQuickActionContext? actionContext;

  @override
  State<MasonryPinGrid> createState() => _MasonryPinGridState();
}

class _MasonryPinGridState extends State<MasonryPinGrid> {
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
  void didUpdateWidget(MasonryPinGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle scroll controller change
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

    if (maxScroll - currentScroll <= widget.loadMoreThreshold) {
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
      crossAxisCount: widget.crossAxisCount,
      mainAxisSpacing: widget.mainAxisSpacing,
      crossAxisSpacing: widget.crossAxisSpacing,
      padding: widget.padding,
      // Pre-build items beyond the viewport for Pinterest-like smooth scrolling
      cacheExtent: 700,
      // FeedPinTile already has RepaintBoundary, avoid duplicate
      addRepaintBoundaries: false,
      // We handle state externally, no need to keep items alive
      addAutomaticKeepAlives: false,
      itemCount: widget.pins.length + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Loading indicator at the end
        if (index >= widget.pins.length) {
          return _buildLoadingIndicator();
        }

        final pin = widget.pins[index];
        return FeedPinTile(
          key: ValueKey('pin_${pin.id}'),
          pin: pin,
          onTap: widget.onPinTap != null ? () => widget.onPinTap!(pin) : null,
          onLongPress: widget.onPinLongPress != null
              ? () => widget.onPinLongPress!(pin)
              : null,
          onSave: widget.onSavePin != null ? () => widget.onSavePin!(pin) : null,
          onOptionsPressed: widget.onPinOptionsPressed != null
              ? () => widget.onPinOptionsPressed!(pin)
              : null,
          showSaveIconOnImage: widget.showSaveIconOnImage,
          borderRadius: widget.showSaveIconOnImage ? 8.0 : 10.0,
          actionContext: widget.actionContext,
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

/// Masonry grid that integrates with CustomScrollView (sliver-based).
/// Use [padding] EdgeInsets.all(8) to match home feed tile size (same as _HomeMasonryPinGrid).
class SliverMasonryPinGrid extends StatelessWidget {
  const SliverMasonryPinGrid({
    super.key,
    required this.pins,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.padding = const EdgeInsets.all(8.0),
    this.showOptionsButton = true,
    this.onPinTap,
    this.onPinLongPress,
    this.onSavePin,
    this.actionContext,
  });

  final List<Pin> pins;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;
  final bool showOptionsButton;
  final void Function(Pin pin)? onPinTap;
  final void Function(Pin pin)? onPinLongPress;
  final void Function(Pin pin)? onSavePin;
  final PinQuickActionContext? actionContext;

  @override
  Widget build(BuildContext context) {
    final grid = SliverMasonryGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childCount: pins.length,
      itemBuilder: (context, index) {
        final pin = pins[index];
        return FeedPinTile(
          key: ValueKey('pin_${pin.id}'),
          pin: pin,
          onTap: onPinTap != null ? () => onPinTap!(pin) : null,
          onLongPress: onPinLongPress != null ? () => onPinLongPress!(pin) : null,
          onSave: onSavePin != null ? () => onSavePin!(pin) : null,
          showOptionsButton: showOptionsButton,
          actionContext: actionContext,
        );
      },
    );
    return SliverPadding(
      padding: padding,
      sliver: grid,
    );
  }
}

/// Scroll controller that preserves position across rebuilds
///
/// Use this when you need to maintain scroll position when
/// the content changes (e.g., after refresh)
class PreservingScrollController extends ScrollController {
  PreservingScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
  });

  double? _lastOffset;

  /// Saves current scroll offset
  void saveOffset() {
    if (hasClients) {
      _lastOffset = offset;
    }
  }

  /// Restores saved scroll offset
  void restoreOffset() {
    if (hasClients && _lastOffset != null) {
      jumpTo(_lastOffset!.clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      ));
    }
  }

  /// Clears saved offset
  void clearSavedOffset() {
    _lastOffset = null;
  }
}
