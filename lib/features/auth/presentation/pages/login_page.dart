// Full-screen authentication page using Clerk
// No AppBar, no Scaffold padding, no SafeArea
// Auth UI takes 100% of screen height and width

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Full-screen authentication screen using Clerk
///
/// Requirements met:
/// - 100% screen height and width
/// - No AppBar
/// - No Scaffold padding
/// - No SafeArea (Clerk handles this internally if needed)
/// - No bottom navigation visible
/// - Supports Google and Email authentication
///
/// Architecture:
/// - Isolated in auth feature
/// - No business logic - Clerk manages all auth operations
/// - Auth state is read-only (managed by Clerk)
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      // No AppBar - body takes full screen
      // Ensure no padding from Scaffold
      resizeToAvoidBottomInset: true,
      // Match background color with theme to prevent clashes
      backgroundColor: colorScheme.surface,
      body: SizedBox.expand(
        child: _AuthContent(
          isDark: isDark,
          colorScheme: colorScheme,
        ),
      ),
    );
  }
}

/// Auth content widget containing Clerk authentication UI
class _AuthContent extends StatelessWidget {
  const _AuthContent({
    required this.isDark,
    required this.colorScheme,
  });

  final bool isDark;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      // Ensure consistent background
      color: colorScheme.surface,
      child: Column(
        children: [
          // Branding header - minimal, native feel
          _BrandingHeader(colorScheme: colorScheme),
          // Clerk Authentication UI - expanded to fill remaining space
          Expanded(
            child: ClerkAuthentication(
              // ClerkAuthentication handles its own SafeArea internally
              // Supports Sign In and Sign Up flows
              // Supports Google and Email authentication based on Clerk dashboard config
            ),
          ),
        ],
      ),
    );
  }
}

/// Minimal branding header for native app feel
class _BrandingHeader extends StatelessWidget {
  const _BrandingHeader({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    // SafeArea only for the header to handle notch/status bar
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pinterest logo/icon
            ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback icon if image not found
                  return Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.thumbtack,
                        color: colorScheme.onPrimary,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // App name
            Text(
              'Pinterest',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 8),
            // Tagline
            Text(
              'Discover ideas for your life',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
