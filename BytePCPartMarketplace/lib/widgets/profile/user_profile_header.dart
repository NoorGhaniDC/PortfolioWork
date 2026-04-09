import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/user_model.dart';

class UserProfileHeader extends StatelessWidget {
  final UserModel? user;

  const UserProfileHeader({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      color: AppColors.primary.withValues(alpha: 0.05),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              // Avatar
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primary,
                child: Text(
                  user?.email.isNotEmpty == true
                      ? user!.email[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // User Name
              Text(
                user?.username ?? 'Seller',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              // Email
              Text(
                user?.email ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              if (user?.bio != null && user!.bio!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  user!.bio!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
