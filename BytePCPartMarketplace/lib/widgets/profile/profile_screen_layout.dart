import 'package:flutter/material.dart';
import '../../models/listing_model.dart';
import '../../widgets/common/app_footer.dart';
import '../../widgets/profile/profile_card.dart';
import '../../widgets/profile/profile_tabs_section.dart';

class ProfileScreenLayout extends StatelessWidget {
  final TabController tabController;
  final dynamic user;

  final bool listedLoading;
  final String? listedError;
  final List<ListingModel> listedListings;
  final Function(String) onDeleteListing;
  final VoidCallback onRetryListed;

  final bool wishlistLoading;
  final String? wishlistError;
  final List<ListingModel> wishlistedListings;
  final Function(String) onDeleteWishlist;
  final VoidCallback onRetryWishlist;

  final bool soldLoading;
  final String? soldError;
  final List<ListingModel> soldListings;
  final VoidCallback onRetrySold;

  final bool purchasedLoading;
  final String? purchasedError;
  final List<ListingModel> purchasedListings;
  final VoidCallback onRetryPurchased;

  final Future<void> Function() onRefresh;
  final VoidCallback onLogout;

  const ProfileScreenLayout({
    required this.tabController,
    required this.user,
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
    required this.onRefresh,
    required this.onLogout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: [
                      // Profile Card
                      ProfileCard(
                        user: user,
                        listingCount: listedListings.length,
                        onLogout: onLogout,
                      ),
                      const SizedBox(height: 40),
                      // Tabs Section
                      ProfileTabsSection(
                        tabController: tabController,
                        listedLoading: listedLoading,
                        listedError: listedError,
                        listedListings: listedListings,
                        onDeleteListing: onDeleteListing,
                        onRetryListed: onRetryListed,
                        wishlistLoading: wishlistLoading,
                        wishlistError: wishlistError,
                        wishlistedListings: wishlistedListings,
                        onDeleteWishlist: onDeleteWishlist,
                        onRetryWishlist: onRetryWishlist,
                        soldLoading: soldLoading,
                        soldError: soldError,
                        soldListings: soldListings,
                        onRetrySold: onRetrySold,
                        purchasedLoading: purchasedLoading,
                        purchasedError: purchasedError,
                        purchasedListings: purchasedListings,
                        onRetryPurchased: onRetryPurchased,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
