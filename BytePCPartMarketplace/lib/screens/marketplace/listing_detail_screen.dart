import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/listing_provider.dart';
import '../../services/auth_service.dart';
import '../../services/listing_service.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/common/error_message.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/listing_detail/listing_detail_layout.dart';
import '../../widgets/listing_detail/login_prompt_dialog.dart';
import '../../widgets/listing_detail/contact_seller_dialog.dart';
import '../../widgets/listing_detail/delete_confirmation_dialog.dart';

class ListingDetailScreen extends StatefulWidget {
  final String listingId;
  const ListingDetailScreen({super.key, required this.listingId});

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  int _currentImageIndex = 0;
  final ListingService _listingService = ListingService();
  bool _isWishlisted = false;
  bool _isCheckingWishlist = true;
  bool _isPurchased = false;
  DateTime? _purchaseDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListingProvider>().fetchListingById(widget.listingId);
      _checkIfWishlisted();
      _checkIfPurchased();
    });
  }

  Future<void> _checkIfPurchased() async {
    final authProvider = context.read<AuthProvider>();
    if (!authProvider.isLoggedIn) {
      return;
    }

    try {
      final userId = authProvider.currentUser!.userId;
      final purchased = await _listingService.getUserPurchasedListings(userId);
      final purchasedItem = purchased.firstWhere(
        (item) => item['listingId'] == widget.listingId,
        orElse: () => <String, dynamic>{},
      );

      if (purchasedItem.isNotEmpty && mounted) {
        final purchaseDate = purchasedItem['purchaseDate'];
        DateTime? parsedDate;
        if (purchaseDate is String) {
          parsedDate = DateTime.parse(purchaseDate);
        } else if (purchaseDate is DateTime) {
          parsedDate = purchaseDate;
        }
        setState(() {
          _isPurchased = true;
          _purchaseDate = parsedDate;
        });
      }
    } catch (e) {
      // Not purchased or error fetching
    }
  }

  Future<void> _checkIfWishlisted() async {
    final authProvider = context.read<AuthProvider>();
    if (!authProvider.isLoggedIn) {
      setState(() => _isCheckingWishlist = false);
      return;
    }

    try {
      final userId = authProvider.currentUser!.userId;
      final wishlist = await _listingService.getUserWishlist(userId);
      final isWishlisted =
          wishlist.any((item) => item['listingId'] == widget.listingId);
      if (mounted) {
        setState(() {
          _isWishlisted = isWishlisted;
          _isCheckingWishlist = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isCheckingWishlist = false);
      }
    }
  }

  Future<void> _toggleWishlist() async {
    final authProvider = context.read<AuthProvider>();
    if (!authProvider.isLoggedIn) {
      showDialog(
        context: context,
        builder: (ctx) => const LoginPromptDialog(
          title: 'Create an Account',
          message:
              'You need to be registered and logged in to add items to your wishlist.',
        ),
      );
      return;
    }

    final userId = authProvider.currentUser!.userId;
    final listing = context.read<ListingProvider>().selectedListing;

    if (listing == null) return;

    try {
      if (_isWishlisted) {
        // Remove from wishlist
        await _listingService.removeFromWishlist(userId, widget.listingId);
        if (mounted) {
          setState(() => _isWishlisted = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Removed from wishlist.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        // Add to wishlist
        await _listingService.addToWishlist(userId, widget.listingId, listing);
        if (mounted) {
          setState(() => _isWishlisted = true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to wishlist!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _deleteListing(String listingId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => const DeleteConfirmationDialog(),
    );

    if (confirmed == true && mounted) {
      final listing = context.read<ListingProvider>().selectedListing;
      if (listing != null) {
        final success = await context
            .read<ListingProvider>()
            .deleteListing(listingId, listing.sellerId);
        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Listing deleted.'),
              backgroundColor: AppColors.success,
            ),
          );
          context.go(AppRoutes.marketplace);
        }
      }
    }
  }

  Future<void> _showContactSeller(String sellerId, bool isLoggedIn) async {
    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (ctx) => const LoginPromptDialog(
          title: 'Create an Account',
          message:
              'You need to be registered and logged in to contact sellers.',
        ),
      );
      return;
    }

    final authService = AuthService();
    final seller = await authService.getUserProfile(sellerId);

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (ctx) => ContactSellerDialog(seller: seller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listingProvider = context.watch<ListingProvider>();
    final authProvider = context.watch<AuthProvider>();
    final isWide = MediaQuery.of(context).size.width > 768;

    if (listingProvider.isLoading) {
      return const Scaffold(appBar: AppNavbar(), body: LoadingIndicator());
    }

    if (listingProvider.errorMessage != null) {
      return Scaffold(
        appBar: const AppNavbar(),
        body: ErrorMessage(message: listingProvider.errorMessage!),
      );
    }

    final listing = listingProvider.selectedListing;
    if (listing == null) {
      return const Scaffold(
        appBar: AppNavbar(),
        body: ErrorMessage(message: 'Listing not found.'),
      );
    }

    final isOwner = authProvider.currentUser?.userId == listing.sellerId;
    final isLoggedIn = authProvider.isLoggedIn;
    final formattedPrice = NumberFormat.currency(symbol: '\$', decimalDigits: 2)
        .format(listing.price);
    final formattedDate = DateFormat('MMM d, yyyy').format(listing.createdAt);

    return Scaffold(
      appBar: const AppNavbar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isWide ? 40 : 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ListingDetailLayout(
              isWide: isWide,
              listing: listing,
              formattedPrice: formattedPrice,
              formattedDate: formattedDate,
              currentImageIndex: _currentImageIndex,
              onImageIndexChanged: (i) =>
                  setState(() => _currentImageIndex = i),
              isOwner: isOwner,
              isLoggedIn: isLoggedIn,
              isWishlisted: _isWishlisted,
              isCheckingWishlist: _isCheckingWishlist,
              isPurchased: _isPurchased,
              purchaseDate: _purchaseDate,
              onDelete: () => _deleteListing(listing.listingId),
              onEdit: () => context.go('/listing/${listing.listingId}/edit'),
              onContactSeller: () =>
                  _showContactSeller(listing.sellerId, isLoggedIn),
              onToggleWishlist: _toggleWishlist,
            ),
          ),
        ),
      ),
    );
  }
}
