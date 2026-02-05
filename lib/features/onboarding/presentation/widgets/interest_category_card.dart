// Pinterest-style category card widget
// Clean, minimal design matching Pinterest onboarding

import 'package:flutter/material.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest/features/onboarding/data/models/interest_category.dart';

/// Pinterest-style category card for interest selection
///
/// Features:
/// - Square card with large rounded corners
/// - Edge-to-edge image with no border/shadow
/// - Subtle scale animation on tap
/// - Clean, flat Pinterest aesthetic
class InterestCategoryCard extends StatefulWidget {
  const InterestCategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final InterestCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<InterestCategoryCard> createState() => _InterestCategoryCardState();
}

class _InterestCategoryCardState extends State<InterestCategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card with image
        Expanded(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image card
                  PinterestCachedImage(
                    imageUrl: widget.category.imageUrl,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(22),
                    placeholder: (_, __) => Container(
                      color: Colors.grey.shade900,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey.shade900,
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.image,
                          color: Colors.grey,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  // Selection indicator
                  if (widget.isSelected)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.all(8),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.black,
                              size: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), // Expanded
        const SizedBox(height: 8),
        // Category label
        Text(
          widget.category.name,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
