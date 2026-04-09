import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'auth_header.dart';
import 'password_input_field.dart';
import 'auth_error_display.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Timer? _errorTimer;
  String? _lastErrorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _errorTimer?.cancel();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (success && mounted) {
      // Initialize notifications for the logged-in user
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final notificationProvider = context.read<NotificationProvider>();
        await notificationProvider.initializeNotifications(uid);
      }

      if (mounted) {
        context.go(AppRoutes.home);
      }
    }
  }

  void _setupErrorTimer(AuthProvider authProvider) {
    if (authProvider.errorMessage != null &&
        authProvider.errorMessage != _lastErrorMessage) {
      _lastErrorMessage = authProvider.errorMessage;
      _errorTimer?.cancel();
      _errorTimer = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          context.read<AuthProvider>().clearError();
          _lastErrorMessage = null;
        }
      });
    } else if (authProvider.errorMessage == null) {
      _lastErrorMessage = null;
      _errorTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    _setupErrorTimer(authProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          AuthHeader(
            title: AppStrings.login,
            subtitle: 'Welcome back to PC Marketplace',
          ),
          const SizedBox(height: 32),

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: AppStrings.email,
              prefixIcon: Icon(Icons.email_outlined),
              hintText: 'Enter your email address',
            ),
            validator: Validators.email,
          ),
          const SizedBox(height: 16),

          // Password
          PasswordInputField(
            controller: _passwordController,
            validator: Validators.password,
          ),
          const SizedBox(height: 24),

          // Error message
          AuthErrorDisplay(
            errorMessage: authProvider.errorMessage,
            isDark: true,
          ),

          // Login button
          authProvider.isLoading
              ? const LoadingIndicator()
              : Tooltip(
                  message: 'Sign in to your account',
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text(
                      AppStrings.login,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
          const SizedBox(height: 16),

          // Register link
          Tooltip(
            message: 'Create a new account',
            child: TextButton(
              onPressed: () => context.go(AppRoutes.register),
              child: const Text(AppStrings.noAccount),
            ),
          ),
        ],
      ),
    );
  }
}
