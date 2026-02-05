// edit_profile_page.dart
// Edit profile page UI
// Form for editing user profile information

import 'package:flutter/material.dart';

/// Edit profile page.
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: const Center(
        child: Text('Update your profile'),
      ),
    );
  }
}
