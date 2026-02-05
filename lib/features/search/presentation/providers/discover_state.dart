// Discover state for search/discover screen
// Manages hero carousel, categories, and idea boards

import 'package:flutter/foundation.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/search/data/models/discover_models.dart';

@immutable
class DiscoverState {
  const DiscoverState({
    this.heroItems = const [],
    this.ideaBoards = const [],
    this.popularCategories = const [],
    this.categoryPins = const {},
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.isInitialized = false,
  });

  final List<HeroItem> heroItems;
  final List<IdeaBoard> ideaBoards;
  final List<DiscoverCategory> popularCategories;
  final Map<String, List<Pin>> categoryPins;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool isInitialized;

  bool get hasError => error != null;
  bool get isEmpty =>
      heroItems.isEmpty && ideaBoards.isEmpty && popularCategories.isEmpty;

  DiscoverState copyWith({
    List<HeroItem>? heroItems,
    List<IdeaBoard>? ideaBoards,
    List<DiscoverCategory>? popularCategories,
    Map<String, List<Pin>>? categoryPins,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? isInitialized,
  }) {
    return DiscoverState(
      heroItems: heroItems ?? this.heroItems,
      ideaBoards: ideaBoards ?? this.ideaBoards,
      popularCategories: popularCategories ?? this.popularCategories,
      categoryPins: categoryPins ?? this.categoryPins,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoverState &&
          runtimeType == other.runtimeType &&
          listEquals(heroItems, other.heroItems) &&
          listEquals(ideaBoards, other.ideaBoards) &&
          listEquals(popularCategories, other.popularCategories) &&
          mapEquals(categoryPins, other.categoryPins) &&
          isLoading == other.isLoading &&
          isLoadingMore == other.isLoadingMore &&
          error == other.error &&
          isInitialized == other.isInitialized;

  @override
  int get hashCode => Object.hash(
        Object.hashAll(heroItems),
        Object.hashAll(ideaBoards),
        Object.hashAll(popularCategories),
        categoryPins.hashCode,
        isLoading,
        isLoadingMore,
        error,
        isInitialized,
      );
}

@immutable
class SearchState {
  const SearchState({
    this.query = '',
    this.isSearchMode = false,
    this.isSearching = false,
    this.results = const [],
    this.recentSearches = const [],
    this.trendingSearches = const [],
    this.suggestions = const [],
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
  });

  final String query;
  final bool isSearchMode;
  final bool isSearching;
  final List<Pin> results;
  final List<RecentSearch> recentSearches;
  final List<TrendingSearch> trendingSearches;
  final List<String> suggestions;
  final String? error;
  final bool hasMore;
  final int currentPage;

  bool get hasError => error != null;
  bool get hasQuery => query.trim().isNotEmpty;
  bool get hasResults => results.isNotEmpty;

  SearchState copyWith({
    String? query,
    bool? isSearchMode,
    bool? isSearching,
    List<Pin>? results,
    List<RecentSearch>? recentSearches,
    List<TrendingSearch>? trendingSearches,
    List<String>? suggestions,
    String? error,
    bool? hasMore,
    int? currentPage,
  }) {
    return SearchState(
      query: query ?? this.query,
      isSearchMode: isSearchMode ?? this.isSearchMode,
      isSearching: isSearching ?? this.isSearching,
      results: results ?? this.results,
      recentSearches: recentSearches ?? this.recentSearches,
      trendingSearches: trendingSearches ?? this.trendingSearches,
      suggestions: suggestions ?? this.suggestions,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchState &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          isSearchMode == other.isSearchMode &&
          isSearching == other.isSearching &&
          listEquals(results, other.results) &&
          listEquals(recentSearches, other.recentSearches) &&
          listEquals(trendingSearches, other.trendingSearches) &&
          listEquals(suggestions, other.suggestions) &&
          error == other.error &&
          hasMore == other.hasMore &&
          currentPage == other.currentPage;

  @override
  int get hashCode => Object.hash(
        query,
        isSearchMode,
        isSearching,
        Object.hashAll(results),
        Object.hashAll(recentSearches),
        Object.hashAll(trendingSearches),
        Object.hashAll(suggestions),
        error,
        hasMore,
        currentPage,
      );
}
