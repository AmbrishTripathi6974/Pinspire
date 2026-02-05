// search_results_page.dart
// Search results full page (used when navigating to search results route with query)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/features/search/presentation/providers/search_provider.dart';
import 'package:pinterest/features/search/presentation/widgets/search_mode_content.dart';
import 'package:pinterest/features/search/presentation/widgets/search_results_grid.dart';

/// Full-page search results for a given query.
class SearchResultsPage extends ConsumerStatefulWidget {
  const SearchResultsPage({super.key, this.query});

  final String? query;

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final q = widget.query;
      if (q != null && q.isNotEmpty) {
        ref.read(searchProvider.notifier).search(q);
        ref.read(searchProvider.notifier).enterSearchMode();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;
    final hasResults = ref.watch(searchResultsProvider).isNotEmpty;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
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
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 20),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Text(
                    widget.query ?? 'Search',
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: hasResults
                ? const SearchResultsGrid()
                : const SearchModeContent(),
          ),
        ],
      ),
    );
  }
}
