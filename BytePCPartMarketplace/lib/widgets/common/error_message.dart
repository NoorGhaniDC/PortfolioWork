import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: const TextStyle(color: AppColors.error, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}