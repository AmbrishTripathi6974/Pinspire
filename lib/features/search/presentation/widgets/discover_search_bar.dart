// Discover search bar widgets
// Pinterest-style pill-shaped search bars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/features/search/presentation/providers/search_notifier.dart';

/// Floating search bar for discover view (overlays hero)
class FloatingSearchBar extends ConsumerWidget {
  const FloatingSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : const Color(0xFFEFEFEF);
    final borderColor = isDark ? Colors.grey.shade500 : Colors.grey.shade500;
    final iconColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return GestureDetector(
      onTap: () {
        ref.read(searchProvider.notifier).enterSearchMode();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15.5),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            FaIcon(
              LucideIcons.search,
              color: iconColor,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search for ideas',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: FaIcon(
                LucideIcons.camera,
                color: iconColor,
                size: 17.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Active search bar for search mode (with text input)
class ActiveSearchBar extends ConsumerStatefulWidget {
  const ActiveSearchBar({super.key});

  @override
  ConsumerState<ActiveSearchBar> createState() => _ActiveSearchBarState();
}

class _ActiveSearchBarState extends ConsumerState<ActiveSearchBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus when search mode is entered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    ref.read(searchProvider.notifier).updateQuery(value);
  }

  void _onSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      ref.read(searchProvider.notifier).search(value);
      _focusNode.unfocus();
    }
  }

  void _clearSearch() {
    _controller.clear();
    ref.read(searchProvider.notifier).updateQuery('');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey.shade800 : Colors.grey.shade100;
    final iconColor = isDark ? Colors.grey.shade400 : Colors.grey.shade700;
    final hintColor = isDark ? Colors.grey.shade500 : Colors.grey.shade500;
    final textColor = isDark ? Colors.white : Colors.black;

    // Sync controller with state
    if (_controller.text != query) {
      _controller.text = query;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: query.length),
      );
    }

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: _onChanged,
              onSubmitted: _onSubmitted,
              cursorColor: isDark ? Colors.white : Colors.black,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: 'Search for ideas',
                hintStyle: TextStyle(
                  color: hintColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
          if (query.isNotEmpty)
            GestureDetector(
              onTap: _clearSearch,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: FaIcon(
                  FontAwesomeIcons.xmark,
                  color: iconColor,
                  size: 18,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: FaIcon(
                FontAwesomeIcons.camera,
                color: iconColor,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

/// Sticky search bar (deprecated - use FloatingSearchBar)
class StickySearchBar extends StatelessWidget {
  const StickySearchBar({
    super.key,
    this.onTap,
    this.onCameraTap,
    this.onBackTap,
    this.showBackButton = false,
  });

  final VoidCallback? onTap;
  final VoidCallback? onCameraTap;
  final VoidCallback? onBackTap;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        top: topPadding + 8,
        left: showBackButton ? 4 : 16,
        right: 16,
        bottom: 8,
      ),
      child: Row(
        children: [
          if (showBackButton) ...[
            GestureDetector(
              onTap: onBackTap,
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
          ],
          const Expanded(child: FloatingSearchBar()),
        ],
      ),
    );
  }
}
