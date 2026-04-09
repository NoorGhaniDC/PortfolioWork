import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final VoidCallback? onChanged;

  const PasswordInputField({
    required this.controller,
    this.labelText = AppStrings.password,
    this.validator,
    this.onChanged,
    super.key,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      onChanged: (_) => widget.onChanged?.call(),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: 'Enter your password (8+ characters)',
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: Tooltip(
          message: 'Show/hide password',
          child: IconButton(
            icon: Icon(_obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined),
            onPressed: () => setState(
              () => _obscurePassword = !_obscurePassword,
            ),
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
