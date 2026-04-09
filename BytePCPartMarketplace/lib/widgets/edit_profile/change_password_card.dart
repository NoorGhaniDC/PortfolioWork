import 'package:flutter/material.dart';
import 'password_field.dart';
import 'edit_profile_helpers.dart';

class ChangePasswordCard extends StatelessWidget {
  final bool showPasswordSection;
  final bool isChangingPassword;
  final bool obscureCurrent;
  final bool obscureNew;
  final bool obscureConfirm;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onToggleSection;
  final VoidCallback onToggleCurrent;
  final VoidCallback onToggleNew;
  final VoidCallback onToggleConfirm;
  final VoidCallback onSubmit;

  const ChangePasswordCard({
    super.key,
    required this.showPasswordSection,
    required this.isChangingPassword,
    required this.obscureCurrent,
    required this.obscureNew,
    required this.obscureConfirm,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onToggleSection,
    required this.onToggleCurrent,
    required this.onToggleNew,
    required this.onToggleConfirm,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeading('Change Password'),
                TextButton(
                  onPressed: onToggleSection,
                  child: Text(showPasswordSection ? 'Cancel' : 'Change'),
                ),
              ],
            ),
            if (showPasswordSection) ...[
              const SizedBox(height: 16),
              PasswordField(
                controller: currentPasswordController,
                label: 'Current Password',
                obscure: obscureCurrent,
                onToggle: onToggleCurrent,
              ),
              const SizedBox(height: 12),
              PasswordField(
                controller: newPasswordController,
                label: 'New Password',
                obscure: obscureNew,
                onToggle: onToggleNew,
              ),
              const SizedBox(height: 12),
              PasswordField(
                controller: confirmPasswordController,
                label: 'Confirm New Password',
                obscure: obscureConfirm,
                onToggle: onToggleConfirm,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Tooltip(
                  message: 'Save new password to your account',
                  child: OutlinedButton(
                    onPressed: isChangingPassword ? null : onSubmit,
                    child: isChangingPassword
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Update Password'),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
