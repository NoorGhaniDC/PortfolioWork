import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'profile_info_card.dart';
import 'change_password_card.dart';

class EditProfileLayout extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  final bool isSaving;
  final bool isChangingPassword;
  final bool showPasswordSection;
  final bool obscureCurrent;
  final bool obscureNew;
  final bool obscureConfirm;

  final VoidCallback onTogglePasswordSection;
  final VoidCallback onToggleCurrent;
  final VoidCallback onToggleNew;
  final VoidCallback onToggleConfirm;
  final Future<void> Function() onSubmitPassword;
  final Future<void> Function() onSaveProfile;

  const EditProfileLayout({
    required this.usernameController,
    required this.bioController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.isSaving,
    required this.isChangingPassword,
    required this.showPasswordSection,
    required this.obscureCurrent,
    required this.obscureNew,
    required this.obscureConfirm,
    required this.onTogglePasswordSection,
    required this.onToggleCurrent,
    required this.onToggleNew,
    required this.onToggleConfirm,
    required this.onSubmitPassword,
    required this.onSaveProfile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 32),

          // Profile Info Card
          ProfileInfoCard(
            usernameController: usernameController,
            bioController: bioController,
            formKey: formKey,
          ),
          const SizedBox(height: 16),

          // Change Password Card
          ChangePasswordCard(
            showPasswordSection: showPasswordSection,
            isChangingPassword: isChangingPassword,
            obscureCurrent: obscureCurrent,
            obscureNew: obscureNew,
            obscureConfirm: obscureConfirm,
            currentPasswordController: currentPasswordController,
            newPasswordController: newPasswordController,
            confirmPasswordController: confirmPasswordController,
            onToggleSection: onTogglePasswordSection,
            onToggleCurrent: onToggleCurrent,
            onToggleNew: onToggleNew,
            onToggleConfirm: onToggleConfirm,
            onSubmit: onSubmitPassword,
          ),
          const SizedBox(height: 24),

          // Save Button
          Tooltip(
            message: 'Update your profile information',
            child: ElevatedButton(
              onPressed: isSaving ? null : onSaveProfile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Save Changes',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
