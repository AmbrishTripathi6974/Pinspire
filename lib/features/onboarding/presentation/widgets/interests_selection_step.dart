// Interests selection step widget
// Third and final step in onboarding flow - single scrollable page

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/features/onboarding/data/models/interest_category.dart';
import 'package:pinterest/features/onboarding/presentation/widgets/interest_category_card.dart';

/// Interests selection step (Step 3 - Final)
///
/// Shows a scrollable grid of all interest categories
/// with "Looking for something else?" section and search at bottom.
/// User must select at least 3 to complete onboarding.
class InterestsSelectionStep extends StatelessWidget {
  const InterestsSelectionStep({
    super.key,
    required this.selectedInterests,
    required this.onInterestToggled,
    required this.onCompletePressed,
    required this.canComplete,
  });

  final Set<String> selectedInterests;
  final ValueChanged<String> onInterestToggled;
  final VoidCallback onCompletePressed;
  final bool canComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        
                        // Title
                        Text(
                          'What are you in the mood to do?',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Subtitle
                        Text(
                          'Pick 3 or more to curate your experience',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              
              // Interest grid - all categories
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 8,
                    // Square image + text label below
                    childAspectRatio: 0.78,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = InterestCategories.all[index];
                      return InterestCategoryCard(
                        category: category,
                        isSelected: selectedInterests.contains(category.id),
                        onTap: () => onInterestToggled(category.id),
                      );
                    },
                    childCount: InterestCategories.all.length,
                  ),
                ),
              ),
              
              // "Looking for something else?" section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      
                      // Text
                      Text(
                        'Looking for something else?',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Search field (UI only)
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search Pinterest',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(14),
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade900,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        onTap: () {
                          // Show a snackbar indicating this is UI only
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Search coming soon!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom padding for the button
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),
        ),
        
        // Next button - fixed at bottom
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: canComplete ? onCompletePressed : null,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFE60023),
                  disabledBackgroundColor: const Color(0xFFE8E4DE),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.grey.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}
