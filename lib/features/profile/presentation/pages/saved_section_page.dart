// saved_section_page.dart
// Saved section: Pins, Boards, Collages tabs (Profile tab root)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/features/profile/presentation/widgets/saved_collages_tab.dart';
import 'package:pinterest/features/profile/presentation/widgets/saved_boards_tab.dart';
import 'package:pinterest/features/profile/presentation/widgets/saved_pins_tab.dart';
import 'package:pinterest/features/profile/presentation/widgets/saved_section_header.dart';

/// Saved section page: header (avatar, Pins | Boards | Collages, search, +)
/// and TabBarView with SavedPinsTab, SavedBoardsTab, SavedCollagesTab.
class SavedSectionPage extends ConsumerStatefulWidget {
  const SavedSectionPage({super.key});

  @override
  ConsumerState<SavedSectionPage> createState() => _SavedSectionPageState();
}

class _SavedSectionPageState extends ConsumerState<SavedSectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Fixed header: does not scroll; only content below scrolls
          SafeArea(
            bottom: false,
            child: SavedSectionHeader(tabController: _tabController),
          ),
          // Scrollable area: tab content only
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                SavedPinsTab(),
                SavedBoardsTab(),
                SavedCollagesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
