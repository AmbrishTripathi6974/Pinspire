// Onboarding progress indicator widget
// Shows dot-based progress matching Pinterest style

import 'package:flutter/material.dart';

/// Progress indicator for onboarding flow
///
/// Shows dots for each step:
/// - Filled dot: completed step
/// - Outlined dot (larger): current step
/// - Small gray dot: future step
class OnboardingProgressIndicator extends StatelessWidget {
  const OnboardingProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (index) {
          return _buildDot(context, index);
        }),
      ),
    );
  }

  Widget _buildDot(BuildContext context, int index) {
    final isCompleted = index < currentStep;
    final isCurrent = index == currentStep;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isCurrent ? 10 : 8,
        height: isCurrent ? 10 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCompleted
              ? Colors.white
              : isCurrent
                  ? Colors.transparent
                  : Colors.grey.shade700,
          border: isCurrent
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
      ),
    );
  }
}
