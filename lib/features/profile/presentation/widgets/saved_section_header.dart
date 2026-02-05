// saved_section_header.dart
// Header for Saved section: avatar, tabs, search bar, + button

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/features/auth/presentation/providers/auth_provider.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';

class SavedSectionHeader extends ConsumerWidget {
  const SavedSectionHeader({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = ref.watch(authStateProvider);
    final avatarUrl = user?.imageUrl;
    final initial = user?.initial ?? 'A';

    // Pinterest-like: tab labels 16–18sp; selected bold
    final tabLabelStyle = theme.textTheme.labelLarge?.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
    );
    final tabLabelSelectedStyle = theme.textTheme.labelLarge?.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: theme.colorScheme.onSurface,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row: avatar + tabs
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.push(AppRoutes.settingsPath),
                child: _Avatar(avatarUrl: avatarUrl, initial: initial),
              ),
              Expanded(
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicatorColor: theme.colorScheme.onSurface,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: theme.colorScheme.onSurface,
                  unselectedLabelColor: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  labelStyle: tabLabelSelectedStyle,
                  unselectedLabelStyle: tabLabelStyle,
                  tabs: const [
                    Tab(text: 'Pins'),
                    Tab(text: 'Boards'),
                    Tab(text: 'Collages'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Search bar + add button
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: _SearchBar(),
              ),
              const SizedBox(width: 12),
              Material(
                color: isDark ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(24),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(24),
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(LucideIcons.plus, size: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Fixed filter row (Pins: grid/Favourites/Created by you | Boards: Sort/Group/Secret | Collages: Created by you/In progress)
        AnimatedBuilder(
          animation: tabController,
          builder: (context, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: _SavedFilterRow(
                tabIndex: tabController.index,
                isDark: isDark,
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Fixed filter row shown below search — content depends on selected tab.
class _SavedFilterRow extends StatelessWidget {
  const _SavedFilterRow({
    required this.tabIndex,
    required this.isDark,
  });

  final int tabIndex;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildChips(context),
      ),
    );
  }

  List<Widget> _buildChips(BuildContext context) {
    const spacing = SizedBox(width: 8);
    final chips = <Widget>[];

    if (tabIndex == 0) {
      // Pins: grid, Favourites, Created by you
      chips.addAll([
        _FilterChip(icon: Icons.grid_on_rounded, label: null, isSelected: true, isDark: isDark),
        spacing,
        _FilterChip(icon: Icons.star_rounded, label: 'Favourites', isSelected: false, isDark: isDark),
        spacing,
        _FilterChip(icon: null, label: 'Created by you', isSelected: false, isDark: isDark),
      ]);
    } else if (tabIndex == 1) {
      // Boards: Sort, Group, Secret
      chips.addAll([
        _FilterChip(icon: Icons.swap_vert, label: null, isSelected: false, isDark: isDark),
        spacing,
        _FilterChip(icon: null, label: 'Group', isSelected: false, isDark: isDark),
        spacing,
        _FilterChip(icon: null, label: 'Secret', isSelected: false, isDark: isDark),
      ]);
    } else {
      // Collages: Created by you, In progress
      chips.addAll([
        _FilterChip(icon: null, label: 'Created by you', isSelected: true, isDark: isDark),
        spacing,
        _FilterChip(icon: null, label: 'In progress', isSelected: false, isDark: isDark),
      ]);
    }
    return chips;
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    this.icon,
    this.label,
    required this.isSelected,
    required this.isDark,
  });

  final IconData? icon;
  final String? label;
  final bool isSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected
        ? (isDark ? Colors.grey.shade700 : Colors.grey.shade300)
        : (isDark ? Colors.grey.shade800 : Colors.grey.shade200);

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14),
                if (label != null) const SizedBox(width: 6),
              ],
              if (label != null)
                Text(
                  label!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.avatarUrl, required this.initial});

  final String? avatarUrl;
  final String initial;

  @override
  Widget build(BuildContext context) {
    const double size = 40;
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ClipOval(
        child: PinterestCachedImage(
          imageUrl: avatarUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.pink.shade100,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.pink.shade800,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? Colors.grey.shade700 : Colors.grey.shade200;
    final bgColor = isDark ? Colors.black : const Color(0xFFEFEFEF);
    final iconColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(LucideIcons.search, size: 20, color: iconColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'Search your Pins',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
