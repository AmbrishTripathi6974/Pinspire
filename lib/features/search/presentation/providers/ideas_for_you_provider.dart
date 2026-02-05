// Ideas for you categories derived from saved pins by source search query

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

const _maxIdeasForYouCategories = 5;

/// Title-case a query for display (e.g. "supercars" -> "Supercars").
String _titleCaseQuery(String query) {
  final t = query.trim();
  if (t.isEmpty) return t;
  return t.split(' ').map((w) {
    if (w.isEmpty) return w;
    return w[0].toUpperCase() + w.substring(1).toLowerCase();
  }).join(' ');
}

/// Categories built from saved pins grouped by the search query they were saved from.
/// Used for the "Ideas for you" section below "Ideas you might like".
final ideasForYouCategoriesProvider = Provider<List<DiscoverCategory>>((ref) {
  // Depend on version so we recompute whenever saved state changes (save/unsave/load).
  ref.watch(savedPinsVersionProvider);
  final savedPins = ref.watch(savedPinsListProvider);
  final savedPinIds = ref.watch(savedPinIdsProvider);
  final sourceQueries = ref.watch(savedPinSourceQueriesProvider);
  if (savedPins.isEmpty || sourceQueries.isEmpty) return [];

  final pinById = {for (final p in savedPins) p.id: p};

  // Group pin IDs by normalized query (trim + toLowerCase).
  // Only consider pins that are still saved (in savedPinIds).
  final queryToPinIds = <String, List<String>>{};
  final queryToDisplayQuery = <String, String>{};
  for (final entry in sourceQueries.entries) {
    final pinId = entry.key;
    if (!savedPinIds.contains(pinId)) continue;
    final q = entry.value.trim();
    if (q.isEmpty) continue;
    final normalized = q.toLowerCase();
    queryToPinIds.putIfAbsent(normalized, () => []).add(pinId);
    queryToDisplayQuery.putIfAbsent(normalized, () => q);
  }
  if (queryToPinIds.isEmpty) return [];
  final categories = <DiscoverCategory>[];
  final entries = queryToPinIds.entries.toList()
    ..sort((a, b) => b.value.length.compareTo(a.value.length));

  for (final entry in entries) {
    if (categories.length >= _maxIdeasForYouCategories) break;
    final normalizedQuery = entry.key;
    final pinIds = entry.value;
    final imageUrls = pinIds
        .where((id) => pinById[id] != null)
        .map((id) => pinById[id]!.imageUrl)
        .toList();
    if (imageUrls.isEmpty) continue;

    final displayQuery = queryToDisplayQuery[normalizedQuery] ?? normalizedQuery;
    categories.add(DiscoverCategory(
      id: 'ideas_${normalizedQuery.replaceAll(' ', '_')}',
      name: _titleCaseQuery(displayQuery),
      query: displayQuery,
      imageUrls: imageUrls,
    ));
  }

  return categories;
});
