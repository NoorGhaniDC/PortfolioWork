import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/edit_profile/edit_profile_layout.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSaving = false;
  bool _isChangingPassword = false;
  bool _showPasswordSection = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().currentUser;
    if (user != null) {
      _usernameController.text = user.username;
      _bioController.text = user.bio ?? '';
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.currentUser!;

    try {
      // Check username uniqueness if changed
      final newUsername = _usernameController.text.trim();
      if (newUsername != user.username) {
        final isTaken = await authProvider.isUsernameTaken(newUsername);
        if (isTaken) {
          if (mounted) _showError('That username is already taken.');
          setState(() => _isSaving = false);
          return;
        }
      }

      await authProvider.updateProfile(
        username: newUsername,
        bio: _bioController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) _showError('Failed to update profile. Please try again.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _changePassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showError('New passwords do not match.');
      return;
    }
    if (_newPasswordController.text.length < 6) {
      _showError('Password must be at least 6 characters.');
      return;
    }

    setState(() => _isChangingPassword = true);
    try {
      await context.read<AuthProvider>().changePassword(
            currentPassword: _currentPasswordController.text,
            newPassword: _newPasswordController.text,
          );
      if (mounted) {
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
        setState(() => _showPasswordSection = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        final msg = e.toString().contains('wrong-password')
            ? 'Current password is incorrect.'
            : 'Failed to change password. Please try again.';
        _showError(msg);
      }
    } finally {
      if (mounted) setState(() => _isChangingPassword = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    if (user == null) return const Scaffold(body: LoadingIndicator());

    final isWide = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      appBar: const AppNavbar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isWide ? 40 : 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: EditProfileLayout(
              usernameController: _usernameController,
              bioController: _bioController,
              currentPasswordController: _currentPasswordController,
              newPasswordController: _newPasswordController,
              confirmPasswordController: _confirmPasswordController,
              formKey: _formKey,
              isSaving: _isSaving,
              isChangingPassword: _isChangingPassword,
              showPasswordSection: _showPasswordSection,
              obscureCurrent: _obscureCurrent,
              obscureNew: _obscureNew,
              obscureConfirm: _obscureConfirm,
              onTogglePasswordSection: () =>
                  setState(() => _showPasswordSection = !_showPasswordSection),
              onToggleCurrent: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
              onToggleNew: () => setState(() => _obscureNew = !_obscureNew),
              onToggleConfirm: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
              onSubmitPassword: _changePassword,
              onSaveProfile: _saveProfile,
            ),
          ),
        ),
      ),
    );
  }
}
