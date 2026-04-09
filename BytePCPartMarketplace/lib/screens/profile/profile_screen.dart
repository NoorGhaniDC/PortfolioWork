import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_routes.dart';
import '../../models/listing_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/listing_provider.dart';
import '../../services/listing_service.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/profile/profile_screen_layout.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final ListingService _listingService = ListingService();

  // Listed items
  List<ListingModel> _userListings = [];
  bool _listedLoading = true;
  String? _listedError;

  // Wishlisted items
  List<Map<String, dynamic>> _wishlistedItems = [];
  bool _wishlistLoading = true;
  String? _wishlistError;

  // Sold items
  List<Map<String, dynamic>> _soldItems = [];
  bool _soldLoading = true;
  String? _soldError;

  // Purchased items
  List<Map<String, dynamic>> _purchasedItems = [];
  bool _purchasedLoading = true;
  String? _purchasedError;

  late TabController _tabController;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Delay to avoid setState during build
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;

        final authProvider = context.read<AuthProvider>();
        if (!authProvider.isLoggedIn) {
          context.go(AppRoutes.login);
        } else {
          _currentUserId = authProvider.currentUser!.userId;
          _loadAllData(_currentUserId!);
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Don't reload here to avoid setState during build
  }

  /// Load all tabs' data at once
  void _loadAllData(String userId) {
    _loadUserListings(userId);
    _loadWishlistedItems(userId);
    _loadSoldItems(userId);
    _loadPurchasedItems(userId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUserListings(String userId) async {
    setState(() {
      _listedLoading = true;
      _listedError = null;
    });
    try {
      final listings = await _listingService.getListingsBySeller(userId);
      setState(() => _userListings = listings);
    } catch (e) {
      setState(
          () => _listedError = 'Failed to load listings. Please try again.');
    } finally {
      setState(() => _listedLoading = false);
    }
  }

  Future<void> _loadWishlistedItems(String userId) async {
    setState(() {
      _wishlistLoading = true;
      _wishlistError = null;
    });
    try {
      final items = await _listingService.getUserWishlist(userId);
      setState(() => _wishlistedItems = items);
    } catch (e) {
      setState(
          () => _wishlistError = 'Failed to load wishlist. Please try again.');
    } finally {
      setState(() => _wishlistLoading = false);
    }
  }

  Future<void> _loadSoldItems(String userId) async {
    setState(() {
      _soldLoading = true;
      _soldError = null;
    });
    try {
      final items = await _listingService.getUserSoldListings(userId);
      setState(() => _soldItems = items);
    } catch (e) {
      setState(
          () => _soldError = 'Failed to load sold items. Please try again.');
    } finally {
      setState(() => _soldLoading = false);
    }
  }

  Future<void> _loadPurchasedItems(String userId) async {
    setState(() {
      _purchasedLoading = true;
      _purchasedError = null;
    });
    try {
      final items = await _listingService.getUserPurchasedListings(userId);
      setState(() => _purchasedItems = items);
    } catch (e) {
      setState(() =>
          _purchasedError = 'Failed to load purchases. Please try again.');
    } finally {
      setState(() => _purchasedLoading = false);
    }
  }

  Future<void> _deleteListing(String listingId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Listing'),
        content: const Text('Are you sure you want to delete this listing?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final userId = context.read<AuthProvider>().currentUser!.userId;
        await context.read<ListingProvider>().deleteListing(listingId, userId);
        await _loadUserListings(userId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Listing deleted.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to delete listing. Please try again.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  Future<void> _removeFromWishlist(String listingId) async {
    if (_currentUserId == null) return;

    try {
      await _listingService.removeFromWishlist(_currentUserId!, listingId);
      await _loadWishlistedItems(_currentUserId!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Removed from wishlist.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to remove from wishlist. Please try again.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<CartProvider>().clear();
      await context.read<AuthProvider>().logout();
      if (mounted) context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    if (user == null) {
      return const Scaffold(
        appBar: AppNavbar(),
        body: LoadingIndicator(),
      );
    }

    return Scaffold(
      appBar: const AppNavbar(),
      body: ProfileScreenLayout(
        tabController: _tabController,
        user: user,
        listedLoading: _listedLoading,
        listedError: _listedError,
        listedListings: _userListings,
        onDeleteListing: _deleteListing,
        onRetryListed: () => _loadUserListings(_currentUserId!),
        wishlistLoading: _wishlistLoading,
        wishlistError: _wishlistError,
        wishlistedListings:
            _wishlistedItems.map((item) => ListingModel.fromMap(item)).toList(),
        onDeleteWishlist: _removeFromWishlist,
        onRetryWishlist: () => _loadWishlistedItems(_currentUserId!),
        soldLoading: _soldLoading,
        soldError: _soldError,
        soldListings:
            _soldItems.map((item) => ListingModel.fromMap(item)).toList(),
        onRetrySold: () => _loadSoldItems(_currentUserId!),
        purchasedLoading: _purchasedLoading,
        purchasedError: _purchasedError,
        purchasedListings:
            _purchasedItems.map((item) => ListingModel.fromMap(item)).toList(),
        onRetryPurchased: () => _loadPurchasedItems(_currentUserId!),
        onRefresh: () async {
          if (_currentUserId != null) {
            await Future.wait([
              _loadUserListings(_currentUserId!),
              _loadWishlistedItems(_currentUserId!),
              _loadSoldItems(_currentUserId!),
              _loadPurchasedItems(_currentUserId!),
            ]);
          }
        },
        onLogout: () => _confirmLogout(),
      ),
    );
  }
}
