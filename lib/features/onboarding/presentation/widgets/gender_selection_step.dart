// Gender selection step widget
// First step in onboarding flow

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/features/onboarding/presentation/providers/onboarding_state.dart';

/// Gender selection step
///
/// Displays three large rounded pill buttons:
/// - Female
/// - Male
/// - Specify another gender
class GenderSelectionStep extends ConsumerWidget {
  const GenderSelectionStep({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  final Gender? selectedGender;
  final ValueChanged<Gender> onGenderSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            
            // Title
            Text(
              'What is your gender?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 12),
            
            // Subtitle
            Text(
              "This helps us find you more relevant content. We won't show it on your profile.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // Gender buttons
            OnboardingPillButton(
              label: 'Female',
              isSelected: selectedGender == Gender.female,
              onTap: () => onGenderSelected(Gender.female),
            ),
            
            const SizedBox(height: 12),
            
            OnboardingPillButton(
              label: 'Male',
              isSelected: selectedGender == Gender.male,
              onTap: () => onGenderSelected(Gender.male),
            ),
            
            const SizedBox(height: 12),
            
            OnboardingPillButton(
              label: 'Specify another gender',
              isSelected: selectedGender == Gender.other,
              onTap: () => onGenderSelected(Gender.other),
            ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

/// Reusable pill-shaped button for onboarding
/// Matches Pinterest's rounded button design
class OnboardingPillButton extends StatefulWidget {
  const OnboardingPillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<OnboardingPillButton> createState() => _OnboardingPillButtonState();
}

class _OnboardingPillButtonState extends State<OnboardingPillButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            // Dark theme background
            color: widget.isSelected ? Colors.grey.shade800 : Colors.grey.shade900,
            // Soft rounded corners (not full pill)
            borderRadius: BorderRadius.circular(12),
            border: widget.isSelected
                ? Border.all(color: Colors.white, width: 1)
                : null,
          ),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
