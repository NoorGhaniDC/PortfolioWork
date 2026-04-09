import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../models/listing_model.dart';
import '../../providers/cart_provider.dart';
import 'listing_detail_widgets.dart';
import 'sales_chart.dart';

class DetailPanel extends StatelessWidget {
  final ListingModel listing;
  final String formattedPrice;
  final String formattedDate;
  final bool isOwner;
  final bool isLoggedIn;
  final bool isWishlisted;
  final bool isCheckingWishlist;
  final bool isPurchased;
  final DateTime? purchaseDate;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onContactSeller;
  final VoidCallback onToggleWishlist;

  const DetailPanel({
    required this.listing,
    required this.formattedPrice,
    required this.formattedDate,
    required this.isOwner,
    required this.isLoggedIn,
    required this.isWishlisted,
    required this.isCheckingWishlist,
    required this.isPurchased,
    required this.purchaseDate,
    required this.onDelete,
    required this.onEdit,
    required this.onContactSeller,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badges
        Row(
          children: [
            ListingBadge(label: listing.category, color: AppColors.primary),
            const SizedBox(width: 8),
            ListingBadge(
              label: listing.condition,
              color: listing.condition == 'New'
                  ? AppColors.success
                  : AppColors.warning,
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Title
        Text(
          listing.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),

        // Price
        Text(
          formattedPrice,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),

        const Divider(),
        const SizedBox(height: 16),

        // Specifications
        const Text(
          'Specifications',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        SpecificationsDisplay(description: listing.description),
        const SizedBox(height: 24),

        // Metadata
        MetaRow(
          icon: Icons.calendar_today_outlined,
          label: 'Listed on $formattedDate',
        ),
        if (isPurchased && purchaseDate != null) ...[
          const SizedBox(height: 12),
          MetaRow(
            icon: Icons.shopping_bag_outlined,
            label:
                'Purchased on ${DateFormat('MMM d, yyyy').format(purchaseDate!)}',
          ),
        ],
        const SizedBox(height: 32),

        // Sales Chart (if listing is active or user is viewing)
        if (listing.isActive) ...[
          SalesChart(listingId: listing.listingId),
          const SizedBox(height: 32),
        ],

        // Actions
        if (isOwner && !listing.isActive) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outlined,
                  color: AppColors.warning,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Item Sold! Congratulations on your sale.',
                    style: TextStyle(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ] else if (isOwner && listing.isActive) ...[
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Manage Listing',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Tooltip(
                  message: 'Modify listing price and condition',
                  child: OutlinedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.primary,
                    ),
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Tooltip(
                  message: 'Remove this listing permanently',
                  child: OutlinedButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    label: const Text(
                      'Delete',
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
        ] else if (isPurchased) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: AppColors.success.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outlined,
                  color: AppColors.success,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'You purchased this item. Thank you for your business!',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          Tooltip(
            message: "Visit the seller's profile to see their other listings",
            child: ElevatedButton.icon(
              onPressed: () => context.go('/user/${listing.sellerId}'),
              icon: const Icon(Icons.storefront_outlined),
              label: const Text(
                "View Seller's Profile",
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Tooltip(
            message: 'Send inquiry to seller via email or messaging',
            child: ElevatedButton.icon(
              onPressed: onContactSeller,
              icon: const Icon(Icons.contact_mail_outlined),
              label:
                  const Text('Contact Seller', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Wishlist button
              if (isCheckingWishlist)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.favorite_outline),
                    label: const Text('Loading...'),
                  ),
                )
              else
                Expanded(
                  child: Tooltip(
                    message: 'Save this item to your wishlist',
                    child: OutlinedButton.icon(
                      onPressed: onToggleWishlist,
                      icon: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_outline,
                        color:
                            isWishlisted ? AppColors.error : AppColors.primary,
                      ),
                      label: Text(
                        isWishlisted ? 'Wishlisted' : 'Wishlist',
                        style: TextStyle(
                          color: isWishlisted
                              ? AppColors.error
                              : AppColors.primary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: isWishlisted
                              ? AppColors.error
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 12),
              // Add to Cart button
              Expanded(
                child: Consumer<CartProvider>(
                  builder: (ctx, cart, _) {
                    final inCart = cart.contains(listing.listingId);
                    return Tooltip(
                      message: 'Add/remove item from shopping cart',
                      child: OutlinedButton.icon(
                        onPressed: inCart
                            ? () => ctx.read<CartProvider>().removeItem(
                                  listing.listingId,
                                )
                            : () => ctx.read<CartProvider>().addItem(listing),
                        icon: Icon(
                          inCart
                              ? Icons.remove_shopping_cart_outlined
                              : Icons.add_shopping_cart_outlined,
                        ),
                        label: Text(inCart ? 'In Cart' : 'To Cart'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (!isLoggedIn) ...[
            const SizedBox(height: 8),
            const Text(
              'Create an account to view seller contact information.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ],

        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: Tooltip(
            message: 'Go back to the marketplace listings',
            child: OutlinedButton.icon(
              onPressed: () => context.go(AppRoutes.marketplace),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Marketplace'),
            ),
          ),
        ),
      ],
    );
  }
}
