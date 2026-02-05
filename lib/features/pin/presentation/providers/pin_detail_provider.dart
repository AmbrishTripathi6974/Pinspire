// pin_detail_provider.dart
// Riverpod provider for pin detail state
// Manages single pin view state and related pins

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/di/injection.dart';
import 'package:pinterest/core/network/exceptions/api_exception.dart';
import 'package:pinterest/core/network/services/pexels_api_service.dart';
import 'package:pinterest/core/network/utils/failure_mapper.dart';
import 'package:pinterest/features/pin/domain/entities/pin.dart';
import 'package:pinterest/features/pin/domain/repositories/pin_repository.dart';
import 'package:pinterest/features/search/domain/repositories/search_repository.dart';

/// State for pin detail page
class PinDetailState {
  const PinDetailState({
    this.pin,
    this.relatedPins = const [],
    this.isLoading = false,
    this.isLoadingRelated = false,
    this.error,
  });

  final Pin? pin;
  final List<Pin> relatedPins;
  final bool isLoading;
  final bool isLoadingRelated;
  final String? error;

  PinDetailState copyWith({
    Pin? pin,
    List<Pin>? relatedPins,
    bool? isLoading,
    bool? isLoadingRelated,
    String? error,
  }) {
    return PinDetailState(
      pin: pin ?? this.pin,
      relatedPins: relatedPins ?? this.relatedPins,
      isLoading: isLoading ?? this.isLoading,
      isLoadingRelated: isLoadingRelated ?? this.isLoadingRelated,
      error: error ?? this.error,
    );
  }
}

/// Notifier for pin detail page
class PinDetailNotifier extends StateNotifier<PinDetailState> {
  PinDetailNotifier({
    required PinRepository pinRepository,
    required SearchRepository searchRepository,
    required PexelsApiService apiService,
    required String pinId,
  })  : _pinRepository = pinRepository,
        _searchRepository = searchRepository,
        _apiService = apiService,
        _pinId = pinId,
        super(const PinDetailState()) {
    _loadPin();
  }

  final PinRepository _pinRepository;
  final SearchRepository _searchRepository;
  final PexelsApiService _apiService;
  final String _pinId;

  /// Load the pin details
  Future<void> _loadPin() async {
    state = state.copyWith(isLoading: true, error: null);

    // First try to get from cache
    final cacheResult = await _pinRepository.getPinById(pinId: _pinId);

    await cacheResult.fold(
      (failure) async {
        // If not in cache, try to fetch from API
        try {
          final pin = await _apiService.getPhotoById(id: _pinId);
          
          // Note: Like/save state will be applied by SavedPinsNotifier
          // which is watched separately in the UI
          state = state.copyWith(
            pin: pin,
            isLoading: false,
            error: null,
          );
          _loadRelatedPins(pin);
        } on ApiException catch (e) {
          state = state.copyWith(
            isLoading: false,
            error: FailureMapper.fromApiException(e).message,
          );
        } catch (e) {
          state = state.copyWith(
            isLoading: false,
            error: 'Failed to load pin',
          );
        }
      },
      (pin) async {
        // Pin found in cache
        state = state.copyWith(
          pin: pin,
          isLoading: false,
          error: null,
        );
        _loadRelatedPins(pin);
      },
    );
  }

  /// Load related pins based on pin description or photographer
  Future<void> _loadRelatedPins(Pin pin) async {
    state = state.copyWith(isLoadingRelated: true);

    // Use description or photographer as search query
    // Extract keywords from description (first few words) or use photographer
    String query;
    if (pin.description?.isNotEmpty == true) {
      // Take first 3-4 words from description for better search results
      final words = pin.description!.split(' ').take(4).join(' ');
      query = words.trim().isNotEmpty ? words.trim() : 'nature';
    } else if (pin.photographer != 'Unknown' && pin.photographer.isNotEmpty) {
      query = pin.photographer;
    } else {
      query = 'nature'; // Fallback query
    }

    final result = await _searchRepository.searchPins(
      query: query,
      page: 1,
      perPage: 20,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingRelated: false,
        );
      },
      (paginatedResult) {
        // Filter out the current pin from related pins
        final relatedPins = paginatedResult.pins
            .where((p) => p.id != pin.id)
            .take(15)
            .toList();

        state = state.copyWith(
          relatedPins: relatedPins,
          isLoadingRelated: false,
        );
      },
    );
  }

  /// Refresh related pins
  Future<void> refreshRelatedPins() async {
    final pin = state.pin;
    if (pin != null) {
      await _loadRelatedPins(pin);
    }
  }
}

/// Provider for pin detail (family provider)
final pinDetailProvider =
    StateNotifierProvider.family<PinDetailNotifier, PinDetailState, String>(
  (ref, pinId) {
    return PinDetailNotifier(
      pinRepository: getIt<PinRepository>(),
      searchRepository: getIt<SearchRepository>(),
      apiService: getIt<PexelsApiService>(),
      pinId: pinId,
    );
  },
);
