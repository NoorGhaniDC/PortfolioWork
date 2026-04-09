import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class ProfileCard extends StatelessWidget {
  final dynamic user;
  final int listingCount;
  final VoidCallback onLogout;

  const ProfileCard({
    super.key,
    required this.user,
    required this.listingCount,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final joinDate = DateFormat('MMMM yyyy').format(user.createdAt);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar — initial only, no photo
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text(
                user.username.isNotEmpty ? user.username[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Username
            Text(
              user.username,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),

            // Email
            Text(
              user.email,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),

            // Bio
            if (user.bio != null && user.bio!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                user.bio!,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatItem(label: 'Listings', value: listingCount.toString()),
                _StatItem(label: 'Member Since', value: joinDate),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // Edit profile button
            SizedBox(
              width: double.infinity,
              child: Tooltip(
                message: 'Update your profile information and photo',
                child: OutlinedButton.icon(
                  onPressed: () => context.push(AppRoutes.editProfile),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Edit Profile'),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Create listing button
            SizedBox(
              width: double.infinity,
              child: Tooltip(
                message: 'List a new PC component for sale',
                child: ElevatedButton.icon(
                  onPressed: () => context.go(AppRoutes.createListing),
                  icon: const Icon(Icons.add),
                  label: const Text('Create Listing'),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: Tooltip(
                message: 'Sign out from your account',
                child: OutlinedButton.icon(
                  onPressed: onLogout,
                  icon: const Icon(Icons.logout, color: AppColors.error),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: AppColors.error),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
