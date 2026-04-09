import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import 'auth_header.dart';
import 'password_input_field.dart';
import 'auth_error_display.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Timer? _errorTimer;
  String? _lastErrorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _errorTimer?.cancel();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await context.read<AuthProvider>().register(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          username: _usernameController.text.trim(),
        );

    if (success && mounted) {
      context.go(AppRoutes.home);
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
            title: AppStrings.createAccount,
            subtitle: 'Join the PC Marketplace community',
          ),
          const SizedBox(height: 32),

          // Username
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: AppStrings.username,
              prefixIcon: Icon(Icons.person_outlined),
              hintText: 'Choose a unique username (3+ characters)',
            ),
            validator: Validators.username,
          ),
          const SizedBox(height: 16),

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: AppStrings.email,
              prefixIcon: Icon(Icons.email_outlined),
              hintText: 'Enter your email address (will receive notifications)',
            ),
            validator: Validators.email,
          ),
          const SizedBox(height: 16),

          // Password
          PasswordInputField(
            controller: _passwordController,
            validator: Validators.password,
          ),
          const SizedBox(height: 16),

          // Confirm Password
          PasswordInputField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return Validators.password(value);
            },
          ),
          const SizedBox(height: 24),

          // Error message
          AuthErrorDisplay(
            errorMessage: authProvider.errorMessage,
          ),

          // Register button
          authProvider.isLoading
              ? const LoadingIndicator()
              : Tooltip(
                  message: 'Create your account and join the marketplace',
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text(
                      AppStrings.createAccount,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
          const SizedBox(height: 16),

          // Login link
          Tooltip(
            message: 'Sign in with existing account',
            child: TextButton(
              onPressed: () => context.go(AppRoutes.login),
              child: const Text(AppStrings.alreadyHaveAccount),
            ),
          ),
        ],
      ),
    );
  }
}
