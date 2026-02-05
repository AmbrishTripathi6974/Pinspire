// Persistent AppShell with bottom navigation
// Tab content is kept alive via StatefulShellRoute.indexedStack; no rebuild on switch.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/save_animation/saved_nav_key.dart';
import 'package:pinterest/core/widgets/create_bottom_sheet.dart';
import 'package:pinterest/core/widgets/loading/masonry_skeleton.dart';
import 'package:pinterest/features/home/presentation/providers/feed_provider.dart';
import 'package:pinterest/features/inbox/presentation/providers/inbox_provider.dart';
import 'package:pinterest/features/search/presentation/providers/discover_notifier.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

/// Persistent AppShell: scaffold + bottom navigation.
///
/// - Uses [StatefulShellRoute.indexedStack] so all tab roots stay mounted.
/// - Tab switch only updates [StatefulNavigationShell.currentIndex]; no route
///   push/replace, no router rebuild, no transition — instant content swap.
/// - Scroll position and navigation stack are preserved per tab.
class ScaffoldWithNav extends ConsumerStatefulWidget {
  const ScaffoldWithNav({
    super.key,
    required this.navigationShell,
  });

  /// The navigation shell from StatefulShellRoute (IndexedStack of branches).
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ScaffoldWithNav> createState() => _ScaffoldWithNavState();
}

class _ScaffoldWithNavState extends ConsumerState<ScaffoldWithNav> {
  bool _skeletonHideScheduled = false;
  Timer? _skeletonHideTimer;

  @override
  void initState() {
    super.initState();
    // Show skeleton on cold start or first login/signup when main app opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(appSkeletonProvider.notifier).show();
      }
    });
  }

  @override
  void dispose() {
    _skeletonHideTimer?.cancel();
    super.dispose();
  }

  void _scheduleSkeletonHideIfReady() {
    if (!mounted) return;
    final skeletonState = ref.read(appSkeletonProvider);
    final feedHasLoaded = ref.read(feedHasLoadedProvider);
    if (!skeletonState.visible || !feedHasLoaded || _skeletonHideScheduled) {
      return;
    }
    _skeletonHideScheduled = true;
    final delay = skeletonState.remainingMinDisplay;
    _skeletonHideTimer?.cancel();
    _skeletonHideTimer = Timer(delay, () {
      if (mounted) {
        ref.read(appSkeletonProvider.notifier).hide();
        _skeletonHideScheduled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isBottomNavVisible = ref.watch(isBottomNavVisibleProvider);
    final skeletonState = ref.watch(appSkeletonProvider);
    final feedHasLoaded = ref.watch(feedHasLoadedProvider);

    // Preload feed so Home and Inbox have data ready (cache or network)
    ref.read(feedProvider);
    // Preload discover so Search tab has data ready on first tap (no delay)
    ref.read(discoverProvider);

    // When skeleton is visible and feed has loaded, hide after min display duration
    if (skeletonState.visible && feedHasLoaded) {
      _scheduleSkeletonHideIfReady();
    } else if (!skeletonState.visible) {
      _skeletonHideScheduled = false;
      _skeletonHideTimer?.cancel();
    }

    return Scaffold(
      body: Stack(
        children: [
          widget.navigationShell,
          if (skeletonState.visible)
            Positioned.fill(
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const SafeArea(
                  top: true,
                  bottom: false,
                  child: MasonrySkeleton(),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        offset: isBottomNavVisible ? Offset.zero : const Offset(0, 1),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isBottomNavVisible ? 1.0 : 0.0,
          child: _BottomNavBar(
            currentIndex: widget.navigationShell.currentIndex,
            onTap: _onTabTapped,
            showInboxBadge: ref.watch(inboxHasUnreadUpdatesProvider),
            savedNavItemKey: savedNavItemKey,
          ),
        ),
      ),
    );
  }

  /// Tab tap: switch branch immediately so first tap navigates, then persist. Create opens bottom sheet instead of tab.
  void _onTabTapped(int index) {
    const createTabIndex = 2;
    if (index == createTabIndex) {
      CreateBottomSheet.show(context);
      return;
    }
    // Navigate first so the first tap immediately shows the search (or other) page
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    ref.read(navigationProvider.notifier).selectTabByIndex(index);
  }
}

/// Bottom navigation bar widget - Pinterest-style: icon + label, same text/size as reference
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    this.showInboxBadge = false,
    required this.savedNavItemKey,
  });

  final int currentIndex;
  final void Function(int) onTap;
  final bool showInboxBadge;
  final GlobalKey savedNavItemKey;

  static const double _iconSize = 24.0;
  static const double _labelFontSize = 11.0;
  static const double _iconLabelGap = 2.0;
  static const double _barHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final selectedColor = isDark ? Colors.white : Colors.black;
    final unselectedColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: _barHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _NavItem(
                  icon: LucideIcons.home,
                  label: 'Home',
                  isSelected: currentIndex == 0,
                  onTap: () => onTap(0),
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  iconSize: _iconSize,
                  labelFontSize: _labelFontSize,
                  iconLabelGap: _iconLabelGap,
                ),
              ),
              SizedBox(width: 8), // Reduced spacing between first and second icon
              Expanded(
                child: _NavItem(
                  icon: LucideIcons.search,
                  label: 'Search',
                  isSelected: currentIndex == 1,
                  onTap: () => onTap(1),
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  iconSize: _iconSize,
                  labelFontSize: _labelFontSize,
                  iconLabelGap: _iconLabelGap,
                ),
              ),
              SizedBox(width: 8), // Reduced spacing between second and third icon
              Expanded(
                child: _NavItem(
                  icon: LucideIcons.plus,
                  label: 'Create',
                  isSelected: currentIndex == 2,
                  onTap: () => onTap(2),
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  iconSize: _iconSize,
                  labelFontSize: _labelFontSize,
                  iconLabelGap: _iconLabelGap,
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: LucideIcons.messageCircle,
                  label: 'Inbox',
                  isSelected: currentIndex == 3,
                  onTap: () => onTap(3),
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  iconSize: _iconSize,
                  labelFontSize: _labelFontSize,
                  iconLabelGap: _iconLabelGap,
                  showBadge: showInboxBadge,
                ),
              ),
              Expanded(
                child: _NavItem(
                  key: savedNavItemKey,
                  icon: LucideIcons.user,
                  label: 'Saved',
                  isSelected: currentIndex == 4,
                  onTap: () => onTap(4),
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  iconSize: _iconSize,
                  labelFontSize: _labelFontSize,
                  iconLabelGap: _iconLabelGap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual navigation item - icon + label, same size and style as reference
class _NavItem extends StatelessWidget {
  const _NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    required this.iconSize,
    required this.labelFontSize,
    required this.iconLabelGap,
    this.showBadge = false,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final double iconSize;
  final double labelFontSize;
  final double iconLabelGap;
  final bool showBadge;

  static const double _badgeDotSize = 8.0;
  static const double _badgeTop = 2.0;
  static const double _badgeRight = 4.0;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? selectedColor : unselectedColor;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        height: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: iconSize, color: color),
                if (showBadge)
                  Positioned(
                    top: -_badgeTop,
                    right: -_badgeRight,
                    child: Container(
                      width: _badgeDotSize,
                      height: _badgeDotSize,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: iconLabelGap),
            Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Extension for easy navigation within the app
extension GoRouterNavExtension on BuildContext {
  /// Navigate to home tab
  void goHome() => go(AppRoutes.home);

  /// Navigate to search tab
  void goSearch() => go(AppRoutes.search);

  /// Navigate to create tab
  void goCreate() => go(AppRoutes.create);

  /// Navigate to notifications tab
  void goNotifications() => go(AppRoutes.notifications);

  /// Navigate to profile tab
  void goProfile() => go(AppRoutes.profile);

  /// Navigate to pin viewer (full-screen)
  void goToPinDetail(String pinId) => go(AppRoutes.pinViewerPath(pinId));

  /// Navigate to board detail
  void goToBoardDetail(String boardId) => go(AppRoutes.boardDetailPath(boardId));

  /// Push pin viewer (preserves back stack)
  void pushPinDetail(String pinId) => push(AppRoutes.pinViewerPath(pinId));

  /// Push board detail (preserves back stack)
  void pushBoardDetail(String boardId) => push(AppRoutes.boardDetailPath(boardId));

  /// Open save to board modal
  void openSaveToBoardModal(String pinId) => push(AppRoutes.savePinToBoardPath(pinId));
}
