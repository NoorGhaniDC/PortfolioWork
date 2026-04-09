import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Listing'),
      content: const Text(
          'Are you sure you want to delete this listing? This cannot be undone.'),
      actions: [
        Tooltip(
          message: "Don't delete the listing",
          child: TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
        ),
        Tooltip(
          message: 'Permanently delete this listing',
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ),
      ],
    );
  }
}
