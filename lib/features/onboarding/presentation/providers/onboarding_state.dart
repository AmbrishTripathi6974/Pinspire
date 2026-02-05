// Onboarding state with Freezed
// Immutable state for post-login onboarding flow

import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

/// Gender options for selection
enum Gender {
  female,
  male,
  other,
}

/// Onboarding step enumeration
enum OnboardingStep {
  gender,
  country,
  interests,
}

/// Immutable state for onboarding flow
@freezed
class OnboardingState with _$OnboardingState {
  const OnboardingState._();

  const factory OnboardingState({
    /// Whether onboarding has been completed
    @Default(false) bool hasCompleted,
    
    /// Current step in the onboarding flow
    @Default(OnboardingStep.gender) OnboardingStep currentStep,
    
    /// Selected gender
    Gender? selectedGender,
    
    /// Custom gender text (when other is selected)
    String? customGender,
    
    /// Selected country code
    String? selectedCountryCode,
    
    /// Selected interest IDs
    @Default({}) Set<String> selectedInterests,
    
    /// Whether the state has been initialized from storage
    @Default(false) bool isInitialized,
    
    /// Loading state
    @Default(false) bool isLoading,
  }) = _OnboardingState;

  /// Current step index (0-based)
  int get currentStepIndex => currentStep.index;

  /// Total number of steps
  int get totalSteps => OnboardingStep.values.length;

  /// Whether gender is selected
  bool get hasGender => selectedGender != null;

  /// Whether country is selected
  bool get hasCountry => selectedCountryCode != null;

  /// Number of selected interests
  int get interestCount => selectedInterests.length;

  /// Whether minimum interests are selected (3 or more)
  bool get hasMinimumInterests => interestCount >= 3;

  /// Whether can proceed to next step based on current step
  bool get canProceed {
    switch (currentStep) {
      case OnboardingStep.gender:
        return hasGender;
      case OnboardingStep.country:
        return hasCountry;
      case OnboardingStep.interests:
        return hasMinimumInterests;
    }
  }

  /// Check if a specific interest is selected
  bool isInterestSelected(String interestId) =>
      selectedInterests.contains(interestId);

  /// Whether this is the last step
  bool get isLastStep => currentStep == OnboardingStep.interests;

  /// Whether this is the first step
  bool get isFirstStep => currentStep == OnboardingStep.gender;
}
