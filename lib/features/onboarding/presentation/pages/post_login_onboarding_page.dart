// Post-login onboarding page
// Main container for the multi-step onboarding flow

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/core/widgets/loading/pinterest_dots_loader.dart';
import 'package:pinterest/features/onboarding/presentation/widgets/country_selection_step.dart';
import 'package:pinterest/features/onboarding/presentation/widgets/gender_selection_step.dart';
import 'package:pinterest/features/onboarding/presentation/widgets/interests_selection_step.dart';
import 'package:pinterest/features/onboarding/presentation/widgets/onboarding_progress_indicator.dart';
import 'package:pinterest/shared/providers/app_providers.dart';

/// Post-login onboarding page
///
/// Multi-step flow shown after first successful login:
/// 1. Gender selection
/// 2. Country/region selection
/// 3. Interest categories (scrollable page with search at bottom)
///
/// Features:
/// - Full-screen layout (no AppBar)
/// - Progress indicator dots
/// - Smooth page transitions
/// - State persistence
class PostLoginOnboardingPage extends ConsumerStatefulWidget {
  const PostLoginOnboardingPage({
    super.key,
    required this.onComplete,
  });

  final VoidCallback onComplete;

  @override
  ConsumerState<PostLoginOnboardingPage> createState() =>
      _PostLoginOnboardingPageState();
}

class _PostLoginOnboardingPageState
    extends ConsumerState<PostLoginOnboardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Sync page controller with initial state after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(onboardingProvider);
      if (state.isInitialized && _pageController.hasClients) {
        _pageController.jumpToPage(state.currentStepIndex);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _handleGenderSelected(Gender gender) async {
    await ref.read(onboardingProvider.notifier).selectGender(gender);
    // Auto-advance after selection with a small delay for visual feedback
    await Future.delayed(const Duration(milliseconds: 300));
    await _handleNextStep();
  }

  Future<void> _handleCountrySelected(String countryCode) async {
    await ref.read(onboardingProvider.notifier).selectCountry(countryCode);
  }

  Future<void> _handleInterestToggled(String interestId) async {
    await ref.read(onboardingProvider.notifier).toggleInterest(interestId);
  }

  Future<void> _handleNextStep() async {
    final state = ref.read(onboardingProvider);
    if (!state.canProceed) return;

    await ref.read(onboardingProvider.notifier).nextStep();
    _animateToPage(state.currentStepIndex + 1);
  }

  Future<void> _handleComplete() async {
    final state = ref.read(onboardingProvider);
    if (!state.canProceed) return;

    await ref.read(onboardingProvider.notifier).completeOnboarding();
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    // Show loading while initializing
    if (!state.isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: PinterestDotsLoader.centered(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            OnboardingProgressIndicator(
              currentStep: state.currentStepIndex,
              totalSteps: state.totalSteps,
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  // Sync state if user somehow navigates differently
                  final currentStep = OnboardingStep.values[index];
                  if (state.currentStep != currentStep) {
                    ref.read(onboardingProvider.notifier).goToStep(currentStep);
                  }
                },
                children: [
                  // Step 1: Gender
                  GenderSelectionStep(
                    selectedGender: state.selectedGender,
                    onGenderSelected: _handleGenderSelected,
                  ),

                  // Step 2: Country
                  CountrySelectionStep(
                    selectedCountryCode: state.selectedCountryCode,
                    onCountrySelected: _handleCountrySelected,
                    onNextPressed: _handleNextStep,
                    canProceed: state.hasCountry,
                  ),

                  // Step 3: Interests (final step)
                  InterestsSelectionStep(
                    selectedInterests: state.selectedInterests,
                    onInterestToggled: _handleInterestToggled,
                    onCompletePressed: _handleComplete,
                    canComplete: state.hasMinimumInterests,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
