# Pinterest-style caching rules

Apply these rules everywhere in the app.

## Image caching

- **Cache first, network second**: Same image URL must never refetch unnecessarily.
- **Centralized loader**: Use `PinterestCachedImage` (and `PinterestCacheManager`) for all network images.
- **Stable cache key**: Cache key = URL; no cache busting from rebuilds.
- **Disk preferred**: Images survive tab switch, scroll recycling, navigation, and app backgrounding.
- **Short fade on first load**: 100ms fade; cached images appear instantly from disk.
- **RepaintBoundary**: Heavy image widgets use RepaintBoundary to avoid rebuild-triggered repaints.

## Data caching

- **No automatic refetch** on: tab switch, widget rebuild, screen re-entry.
- **Refresh only when user explicitly pulls to refresh.**
- **Cached data shown instantly** on revisit (feed, discover, trending, search results).
- **New data replaces cache** only after refresh completes.
- **Prefer stale-but-visible** over blank loading states; loading shimmer only when cache is empty.

## What not to do

- Do NOT refetch data on every build.
- Do NOT clear cache on tab switch.
- Do NOT rely on widget lifecycle for caching.
- Do NOT aggressively invalidate image cache (e.g. on app pause).
- Do NOT mix caching logic into UI widgets.
