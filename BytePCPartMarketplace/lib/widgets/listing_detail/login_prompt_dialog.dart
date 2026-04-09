import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_routes.dart';

class LoginPromptDialog extends StatelessWidget {
  final String title;
  final String message;

  const LoginPromptDialog({
    required this.title,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        Tooltip(
          message: 'Close this dialog',
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
        Tooltip(
          message: 'Create account to proceed',
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(AppRoutes.register);
            },
            child: const Text('Register'),
          ),
        ),
      ],
    );
  }
}
