import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/listing_model.dart';
import 'user_listings_panel.dart';

class ProfileTabsSection extends StatelessWidget {
  final TabController tabController;

  // Listed items
  final bool listedLoading;
  final String? listedError;
  final List<ListingModel> listedListings;
  final Function(String) onDeleteListing;
  final VoidCallback onRetryListed;

  // Wishlisted items
  final bool wishlistLoading;
  final String? wishlistError;
  final List<ListingModel> wishlistedListings;
  final Function(String) onDeleteWishlist;
  final VoidCallback onRetryWishlist;

  // Sold items
  final bool soldLoading;
  final String? soldError;
  final List<ListingModel> soldListings;
  final VoidCallback onRetrySold;

  // Purchased items
  final bool purchasedLoading;
  final String? purchasedError;
  final List<ListingModel> purchasedListings;
  final VoidCallback onRetryPurchased;

  const ProfileTabsSection({
    Key? key,
    required this.tabController,
    required this.listedLoading,
    required this.listedError,
    required this.listedListings,
    required this.onDeleteListing,
    required this.onRetryListed,
    required this.wishlistLoading,
    required this.wishlistError,
    required this.wishlistedListings,
    required this.onDeleteWishlist,
    required this.onRetryWishlist,
    required this.soldLoading,
    required this.soldError,
    required this.soldListings,
    required this.onRetrySold,
    required this.purchasedLoading,
    required this.purchasedError,
    required this.purchasedListings,
    required this.onRetryPurchased,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600, // Fixed height for tabs
      child: Column(
        children: [
          // TabBar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: TabBar(
              controller: tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              tabs: const [
                Tab(text: 'Listed'),
                Tab(text: 'Wishlisted'),
                Tab(text: 'Sold'),
                Tab(text: 'Purchased'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                // Listed Items Tab
                UserListingsPanel(
                  isLoading: listedLoading,
                  error: listedError,
                  listings: listedListings,
                  onDelete: onDeleteListing,
                  onRetry: onRetryListed,
                  headerText: 'My Listings',
                  emptyMessage: 'No listings yet.',
                  emptyIcon: Icons.list_alt_outlined,
                  showCreateButton: false,
                ),
                // Wishlisted Items Tab
                UserListingsPanel(
                  isLoading: wishlistLoading,
                  error: wishlistError,
                  listings: wishlistedListings,
                  onDelete: onDeleteWishlist,
                  onRetry: onRetryWishlist,
                  headerText: 'Wishlist',
                  emptyMessage: 'No wishlisted items yet.',
                  emptyIcon: Icons.favorite_outline,
                  showCreateButton: false,
                  showSoldStatus: true,
                ),
                // Sold Items Tab
                UserListingsPanel(
                  isLoading: soldLoading,
                  error: soldError,
                  listings: soldListings,
                  onDelete: (listingId) => onRetrySold(),
                  onRetry: onRetrySold,
                  headerText: 'Sold',
                  emptyMessage: 'No sold items yet.',
                  emptyIcon: Icons.sell_outlined,
                  showCreateButton: false,
                ),
                // Purchased Items Tab
                UserListingsPanel(
                  isLoading: purchasedLoading,
                  error: purchasedError,
                  listings: purchasedListings,
                  onDelete: (listingId) => onRetryPurchased(),
                  onRetry: onRetryPurchased,
                  headerText: 'Purchased',
                  emptyMessage: 'No purchased items yet.',
                  emptyIcon: Icons.shopping_bag_outlined,
                  showCreateButton: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
