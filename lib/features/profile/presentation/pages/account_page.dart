// account_page.dart
// Your account screen with profile row, settings list, and working Log out

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pinterest/core/router/routes.dart';
import 'package:pinterest/core/utils/constants/storage_keys.dart';
import 'package:pinterest/features/auth/presentation/providers/auth_provider.dart';
import 'package:pinterest/features/auth/presentation/widgets/clerk_auth_scope.dart';
import 'package:pinterest/shared/providers/app_providers.dart';
import 'package:pinterest/shared/widgets/pinterest_cached_image.dart';

/// Your account page: profile summary and settings list.
/// Only "Log out" is functional; other items are UI-only.
class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  static const List<_SettingsItem> _settingsItems = [
    _SettingsItem('Account management', showChevron: true),
    _SettingsItem('Profile visibility', showChevron: true),
    _SettingsItem('Refine your recommendations', showChevron: true),
    _SettingsItem('Claimed external accounts', showChevron: true),
    _SettingsItem('Social permissions', showChevron: true),
    _SettingsItem('Notifications', showChevron: true),
    _SettingsItem('Privacy and data', showChevron: true),
    _SettingsItem('Reports and violations centre', showChevron: true),
    _SettingsItem('Login', showChevron: false),
    _SettingsItem('Security', showChevron: true),
    _SettingsItem('Log out', showChevron: false, isLogOut: true),
    _SettingsItem('Support', showChevron: false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authStateProvider);
    final displayName = user?.displayName ?? 'User';
    final avatarUrl = user?.imageUrl;
    final initial = user?.initial ?? 'U';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Your account',
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // Profile row
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: _Avatar(avatarUrl: avatarUrl, initial: initial),
            title: Text(
              displayName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              'View profile',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(LucideIcons.chevronRight, size: 20, color: theme.colorScheme.onSurfaceVariant),
            ),
            onTap: () => context.push(AppRoutes.editProfilePath),
          ),
          const SizedBox(height: 16),
          // Settings header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Text(
              'Settings',
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          // Settings list
          ..._settingsItems.map((item) {
            if (item.isLogOut) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                title: Text(
                  item.label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => _onLogOut(context, ref),
              );
            }
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                item.label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: item.showChevron
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        LucideIcons.chevronRight,
                        size: 20,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    )
                  : null,
              onTap: () {},
            );
          }),
        ],
      ),
    );
  }

  Future<void> _onLogOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (context.mounted && confirmed == true) {
      final authState = ClerkAuthScope.maybeOf(context)?.authState;
      if (authState != null) {
        await authState.signOut();
      }
      if (context.mounted) {
        ref.read(authStateProvider.notifier).clearUser();
        // Clear logged in flag in local storage
        final localStorage = ref.read(localStorageProvider);
        await localStorage.setBool(StorageKeys.isLoggedIn, false);
        // Fallback: if we did not have ClerkAuthScope (e.g. scope null), navigate to login
        if (authState == null) {
          context.go(AppRoutes.login);
        }
      }
    }
  }
}

class _SettingsItem {
  const _SettingsItem(
    this.label, {
    this.showChevron = true,
    this.isLogOut = false,
  });
  final String label;
  final bool showChevron;
  final bool isLogOut;
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.avatarUrl, required this.initial});

  final String? avatarUrl;
  final String initial;

  @override
  Widget build(BuildContext context) {
    const double size = 48;
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ClipOval(
        child: PinterestCachedImage(
          imageUrl: avatarUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.pink.shade100,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.pink.shade800,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}
