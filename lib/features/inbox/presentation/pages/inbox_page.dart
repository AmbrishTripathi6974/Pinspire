// Inbox / Updates page - Pinterest-style with real features
// Messages section + Invite card + Updates from feed (mark read, hide, report)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/home/presentation/providers/feed_provider.dart';
import 'package:pinterest/features/inbox/data/models/cached_inbox_data.dart';
import 'package:pinterest/features/inbox/domain/entities/inbox_update.dart';
import 'package:pinterest/features/inbox/presentation/providers/inbox_provider.dart';
import 'package:pinterest/shared/providers/app_providers.dart';
import 'package:pinterest/features/inbox/presentation/widgets/inbox_invite_card.dart';
import 'package:pinterest/features/inbox/presentation/widgets/inbox_update_item.dart';
import 'package:pinterest/features/inbox/presentation/widgets/inbox_update_options_bottom_sheet.dart';
import 'package:pinterest/shared/widgets/pinterest_refresh_indicator.dart';

/// Inbox page: header "Inbox", Messages + Invite card, Updates list.
/// Features: real updates from feed, pull-to-refresh, tap → pin detail + mark read,
/// three dots → Hide / Report, See all → Messages, Invite friends, Pencil → Messages.
class InboxPage extends ConsumerStatefulWidget {
  const InboxPage({super.key});

  @override
  ConsumerState<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends ConsumerState<InboxPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(feedProvider.notifier).refresh();
    if (mounted && _scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onUpdateTap(InboxUpdate update) {
    ref.read(inboxNotifierProvider.notifier).markAsRead(update.pinId);
    context.push(AppRoutes.topicPath(update.title));
  }

  void _onUpdateMoreTap(InboxUpdate update) {
    InboxUpdateOptionsBottomSheet.show(
      context: context,
      update: update,
      onHide: () {
        ref.read(inboxNotifierProvider.notifier).hideUpdate(update.pinId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Update hidden'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      onReport: () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Report submitted. Thank you!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }

  void _onInviteTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invite friends to start chatting'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? Colors.black : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black;
    final sectionTitleColor = isDark ? Colors.white : Colors.black;
    final seeAllColor = isDark ? Colors.grey.shade400 : Colors.grey.shade700;

    final updates = ref.watch(inboxDisplayUpdatesProvider);
    final isInitialLoading = ref.watch(feedIsInitialLoadingProvider);

    // Persist feed-based updates to cache for instant load next time
    ref.listen<List<InboxUpdate>>(inboxUpdatesProvider, (prev, next) {
      if (next.isNotEmpty) {
        final data = CachedInboxData(
          updates: next.map(CachedInboxUpdateItem.fromInboxUpdate).toList(),
          cachedAt: DateTime.now(),
        );
        ref.read(localStorageProvider).setJson(
              StorageKeys.inboxUpdatesCache,
              data.toJson(),
            );
      }
    });

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: PinterestRefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // Header: "Inbox" + pencil icon
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Inbox',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: titleColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            context.push(AppRoutes.inboxMessagesPath),
                        icon: Icon(
                          LucideIcons.edit3,
                          size: 24,
                          color: titleColor,
                        ),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(48, 48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Messages section header: "Messages" + "See all" + chevron
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    children: [
                      Text(
                        'Messages',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: sectionTitleColor,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () =>
                            context.push(AppRoutes.inboxMessagesPath),
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'See all',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: seeAllColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              LucideIcons.chevronRight,
                              size: 20,
                              color: seeAllColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Invite your friends card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InboxInviteCard(onTap: _onInviteTap),
                ),
              ),

              // Updates section header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Updates',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: sectionTitleColor,
                      ),
                    ),
                  ),
                ),
              ),

              // Loading only when no cache and feed is still loading
              if (isInitialLoading && updates.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: PinterestDotsLoader.centered(),
                  ),
                )
              else if (updates.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            LucideIcons.bellOff,
                            size: 48,
                            color: seeAllColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No updates yet',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: seeAllColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pull down to refresh. When people you follow add new pins, they\'ll show up here.',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: seeAllColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                // Updates list
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final update = updates[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InboxUpdateItem(
                          title: update.title,
                          timeAgo: update.timeAgo,
                          imageUrl: update.imageUrl,
                          isUnread: update.isUnread,
                          onTap: () => _onUpdateTap(update),
                          onMoreTap: () => _onUpdateMoreTap(update),
                        ),
                      );
                    },
                    childCount: updates.length,
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
