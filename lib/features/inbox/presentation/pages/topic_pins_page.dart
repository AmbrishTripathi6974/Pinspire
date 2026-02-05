// Update topic page - title above masonry grid of related pins
// Pinterest-style: back + centered title, grid of images for that topic

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/home/presentation/widgets/masonry_grid.dart';
import 'package:pinterest/features/home/presentation/widgets/pin_options_bottom_sheet.dart';
import 'package:pinterest/features/inbox/presentation/providers/topic_pins_provider.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

/// Topic pins page: app bar with title + masonry grid of pins related to that title.
/// Opened when user taps an update in Inbox; shows search results for the update title.
class TopicPinsPage extends ConsumerStatefulWidget {
  const TopicPinsPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  ConsumerState<TopicPinsPage> createState() => _TopicPinsPageState();
}

class _TopicPinsPageState extends ConsumerState<TopicPinsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onPinTap(Pin pin) {
    // Use root-level pin viewer to avoid Navigator key conflict when coming from
    // a root route (TopicPinsPage). Pushing /home/pin/:id would target the home
    // shell branch and can trigger keyReservation assertion.
    context.push(AppRoutes.pinViewerPath(pin.id));
  }

  void _onSavePin(Pin pin) {
    ref.read(savedPinsProvider.notifier).toggleSavePin(pin);
  }

  void _onPinOptionsPressed(Pin pin) {
    PinOptionsBottomSheet.show(
      context: context,
      pin: pin,
      inspirationText: 'This Pin is related to "${widget.title}".',
      onSave: () => _onSavePin(pin),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? Colors.black : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black;

    final topicState = ref.watch(topicPinsProvider(widget.title));
    final savedPinIds = ref.watch(savedPinsProvider.select((s) => s.savedPinIds));
    final pins = topicState.pins
        .map((p) => p.copyWith(saved: savedPinIds.contains(p.id)))
        .toList();
    final hasMore = topicState.hasMore;
    final isLoadingMore = topicState.isLoadingMore;
    final isInitialLoading = topicState.isInitialLoading;
    final error = topicState.error;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(LucideIcons.arrowLeft, color: titleColor),
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(
        isDark: isDark,
        pins: pins,
        hasMore: hasMore,
        isLoadingMore: isLoadingMore,
        isInitialLoading: isInitialLoading,
        error: error,
      ),
    );
  }

  Widget _buildBody({
    required bool isDark,
    required List<Pin> pins,
    required bool hasMore,
    required bool isLoadingMore,
    required bool isInitialLoading,
    required String? error,
  }) {
    if (isInitialLoading && pins.isEmpty) {
      return PinterestDotsLoader.centered();
    }

    if (error != null && pins.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.alertCircle,
                size: 48,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              const SizedBox(height: 16),
              Text(
                error,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  ref.read(topicPinsProvider(widget.title).notifier).loadInitial();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (pins.isEmpty) {
      return Center(
        child: Text(
          'No pins for this topic',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      );
    }

    return MasonryPinGrid(
      pins: pins,
      onLoadMore: () {
        ref.read(topicPinsProvider(widget.title).notifier).loadMore();
      },
      hasMore: hasMore,
      isLoadingMore: isLoadingMore,
      scrollController: _scrollController,
      onPinTap: _onPinTap,
      onSavePin: _onSavePin,
      onPinOptionsPressed: _onPinOptionsPressed,
      showSaveIconOnImage: true,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
    );
  }
}
