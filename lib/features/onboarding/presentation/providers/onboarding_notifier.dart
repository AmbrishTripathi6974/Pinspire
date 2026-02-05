// Onboarding StateNotifier with SharedPreferences persistence
// Manages post-login onboarding flow state

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/storage/local_storage_service.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/onboarding/presentation/providers/onboarding_state.dart';

/// StateNotifier for onboarding flow
///
/// Handles:
/// - Step navigation
/// - Selection state
/// - Persistence to SharedPreferences
/// - Restoration on app restart
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier({
    required LocalStorageService localStorage,
  })  : _localStorage = localStorage,
        super(const OnboardingState()) {
    _loadPersistedState();
  }

  final LocalStorageService _localStorage;

  /// Loads persisted state from SharedPreferences
  Future<void> _loadPersistedState() async {
    try {
      final hasCompleted = _localStorage.getBool(
            StorageKeys.hasCompletedPostLoginOnboarding,
          ) ??
          false;

      if (hasCompleted) {
        state = state.copyWith(
          hasCompleted: true,
          isInitialized: true,
        );
        return;
      }

      // Load current step
      final stepIndex =
          _localStorage.getInt(StorageKeys.onboardingCurrentStep) ?? 0;
      final currentStep = stepIndex < OnboardingStep.values.length
          ? OnboardingStep.values[stepIndex]
          : OnboardingStep.gender;

      // Load gender
      final genderIndex = _localStorage.getInt(StorageKeys.onboardingGender);
      final selectedGender = genderIndex != null && genderIndex < Gender.values.length
          ? Gender.values[genderIndex]
          : null;

      // Load country (default to India if not set)
      final savedCountryCode = _localStorage.getString(StorageKeys.onboardingCountry);
      final selectedCountryCode = savedCountryCode ?? 'IN';
      
      // Persist India as default if not already saved
      if (savedCountryCode == null) {
        await _localStorage.setString(StorageKeys.onboardingCountry, 'IN');
      }

      // Load interests
      final interestsList =
          _localStorage.getStringList(StorageKeys.onboardingInterests) ?? [];
      final selectedInterests = interestsList.toSet();

      state = state.copyWith(
        hasCompleted: false,
        currentStep: currentStep,
        selectedGender: selectedGender,
        selectedCountryCode: selectedCountryCode,
        selectedInterests: selectedInterests,
        isInitialized: true,
      );
    } catch (_) {
      state = state.copyWith(isInitialized: true);
    }
  }

  /// Persists current state to SharedPreferences
  Future<void> _persistState() async {
    try {
      await _localStorage.setBool(
        StorageKeys.hasCompletedPostLoginOnboarding,
        state.hasCompleted,
      );
      await _localStorage.setInt(
        StorageKeys.onboardingCurrentStep,
        state.currentStep.index,
      );

      if (state.selectedGender != null) {
        await _localStorage.setInt(
          StorageKeys.onboardingGender,
          state.selectedGender!.index,
        );
      }

      if (state.selectedCountryCode != null) {
        await _localStorage.setString(
          StorageKeys.onboardingCountry,
          state.selectedCountryCode!,
        );
      }

      await _localStorage.setStringList(
        StorageKeys.onboardingInterests,
        state.selectedInterests.toList(),
      );
    } catch (_) {
      // Silently fail
    }
  }

  /// Sets the selected gender
  Future<void> selectGender(Gender gender, {String? customText}) async {
    state = state.copyWith(
      selectedGender: gender,
      customGender: gender == Gender.other ? customText : null,
    );
    await _persistState();
  }

  /// Sets the selected country
  Future<void> selectCountry(String countryCode) async {
    state = state.copyWith(selectedCountryCode: countryCode);
    await _persistState();
  }

  /// Toggles an interest selection
  Future<void> toggleInterest(String interestId) async {
    final currentInterests = Set<String>.from(state.selectedInterests);

    if (currentInterests.contains(interestId)) {
      currentInterests.remove(interestId);
    } else {
      currentInterests.add(interestId);
    }

    state = state.copyWith(selectedInterests: currentInterests);
    await _persistState();
  }

  /// Moves to the next step
  Future<void> nextStep() async {
    if (!state.canProceed) return;

    final currentIndex = state.currentStep.index;
    if (currentIndex < OnboardingStep.values.length - 1) {
      state = state.copyWith(
        currentStep: OnboardingStep.values[currentIndex + 1],
      );
      await _persistState();
    }
  }

  /// Moves to the previous step
  Future<void> previousStep() async {
    final currentIndex = state.currentStep.index;
    if (currentIndex > 0) {
      state = state.copyWith(
        currentStep: OnboardingStep.values[currentIndex - 1],
      );
      await _persistState();
    }
  }

  /// Goes to a specific step
  Future<void> goToStep(OnboardingStep step) async {
    state = state.copyWith(currentStep: step);
    await _persistState();
  }

  /// Completes the onboarding flow
  Future<void> completeOnboarding() async {
    state = state.copyWith(
      hasCompleted: true,
      isLoading: false,
    );
    await _persistState();
  }

  /// Sets loading state
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  /// Resets onboarding (for testing/debugging)
  Future<void> resetOnboarding() async {
    state = const OnboardingState(isInitialized: true);
    await _localStorage.remove(StorageKeys.hasCompletedPostLoginOnboarding);
    await _localStorage.remove(StorageKeys.onboardingCurrentStep);
    await _localStorage.remove(StorageKeys.onboardingGender);
    await _localStorage.remove(StorageKeys.onboardingCountry);
    await _localStorage.remove(StorageKeys.onboardingInterests);
  }
}
