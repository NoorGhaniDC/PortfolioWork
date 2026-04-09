import 'package:flutter/material.dart';
import '../../models/listing_model.dart';
import '../../widgets/listing_detail/image_panel.dart';
import '../../widgets/listing_detail/detail_panel.dart';

class ListingDetailLayout extends StatelessWidget {
  final bool isWide;
  final ListingModel listing;
  final String formattedPrice;
  final String formattedDate;
  final int currentImageIndex;
  final ValueChanged<int> onImageIndexChanged;
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

  const ListingDetailLayout({
    required this.isWide,
    required this.listing,
    required this.formattedPrice,
    required this.formattedDate,
    required this.currentImageIndex,
    required this.onImageIndexChanged,
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isWide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ImagePanel(
                  imageUrls: listing.imageUrls,
                  category: listing.category,
                  currentIndex: currentImageIndex,
                  onIndexChanged: onImageIndexChanged,
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 3,
                child: DetailPanel(
                  listing: listing,
                  formattedPrice: formattedPrice,
                  formattedDate: formattedDate,
                  isOwner: isOwner,
                  isLoggedIn: isLoggedIn,
                  isWishlisted: isWishlisted,
                  isCheckingWishlist: isCheckingWishlist,
                  isPurchased: isPurchased,
                  purchaseDate: purchaseDate,
                  onDelete: onDelete,
                  onEdit: onEdit,
                  onContactSeller: onContactSeller,
                  onToggleWishlist: onToggleWishlist,
                ),
              ),
            ],
          )
        : Column(
            children: [
              ImagePanel(
                imageUrls: listing.imageUrls,
                category: listing.category,
                currentIndex: currentImageIndex,
                onIndexChanged: onImageIndexChanged,
              ),
              const SizedBox(height: 24),
              DetailPanel(
                listing: listing,
                formattedPrice: formattedPrice,
                formattedDate: formattedDate,
                isOwner: isOwner,
                isLoggedIn: isLoggedIn,
                isWishlisted: isWishlisted,
                isCheckingWishlist: isCheckingWishlist,
                isPurchased: isPurchased,
                purchaseDate: purchaseDate,
                onDelete: onDelete,
                onEdit: onEdit,
                onContactSeller: onContactSeller,
                onToggleWishlist: onToggleWishlist,
              ),
            ],
          );
  }
}
