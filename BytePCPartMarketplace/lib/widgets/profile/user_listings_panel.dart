import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../models/listing_model.dart';
import '../../widgets/common/loading_indicator.dart';
import 'listing_row.dart';

class UserListingsPanel extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<ListingModel> listings;
  final Function(String) onDelete;
  final VoidCallback onRetry;
  final String headerText;
  final String emptyMessage;
  final IconData emptyIcon;
  final bool showCreateButton;
  final bool showSoldStatus;

  const UserListingsPanel({
    super.key,
    required this.isLoading,
    required this.error,
    required this.listings,
    required this.onDelete,
    required this.onRetry,
    this.headerText = 'My Listings',
    this.emptyMessage = 'No listings found',
    this.emptyIcon = Icons.sell_outlined,
    this.showCreateButton = false,
    this.showSoldStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: LoadingIndicator()),
      );
    }
    if (error != null) {
      return _ListingsError(message: error!, onRetry: onRetry);
    }
    if (listings.isEmpty) {
      return _EmptyListings(
        message: emptyMessage,
        icon: emptyIcon,
        showCreateButton: showCreateButton,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: listings.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          // Header
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              headerText,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          );
        }
        final listing = listings[index - 1];
        return ListingRow(
          listing: listing,
          onDelete: () => onDelete(listing.listingId),
          isSold: showSoldStatus && !listing.isActive,
        );
      },
    );
  }
}

// ─── Error State ───────────────────────────────────────────────────────────
class _ListingsError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ListingsError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            const Icon(Icons.cloud_off_outlined,
                size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Tooltip(
              message: 'Retry loading listings',
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty State ────────────────────────────────────────────────────────────
class _EmptyListings extends StatelessWidget {
  final String message;
  final IconData icon;
  final bool showCreateButton;

  const _EmptyListings({
    required this.message,
    required this.icon,
    required this.showCreateButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            Icon(icon, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            if (showCreateButton) ...[
              const SizedBox(height: 8),
              const Text(
                'Create your first listing to start selling',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              Tooltip(
                message: 'Create your first listing',
                child: ElevatedButton.icon(
                  onPressed: () => context.go(AppRoutes.createListing),
                  icon: const Icon(Icons.add),
                  label: const Text('Create Listing'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
