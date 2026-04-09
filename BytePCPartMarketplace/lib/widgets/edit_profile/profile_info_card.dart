import 'package:flutter/material.dart';
import 'edit_profile_helpers.dart';

class ProfileInfoCard extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final GlobalKey<FormState> formKey;

  const ProfileInfoCard({
    required this.usernameController,
    required this.bioController,
    required this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading('Profile Info'),
            const SizedBox(height: 16),
            // Username field
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline),
                hintText:
                    'Display name visible to other users (3-30 characters)',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Username cannot be empty';
                }
                if (v.trim().length < 3) {
                  return 'Username must be at least 3 characters';
                }
                if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(v.trim())) {
                  return 'Only letters, numbers, and underscores allowed';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Bio field
            TextFormField(
              controller: bioController,
              maxLines: 3,
              maxLength: 160,
              decoration: const InputDecoration(
                labelText: 'Bio',
                alignLabelWithHint: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 48),
                  child: Icon(Icons.notes_outlined),
                ),
                hintText: 'Brief description about you (max 160 characters)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
