import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/listing_provider.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/common/error_message.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/listing/listing_card.dart';
import '../../widgets/marketplace/search_filter_bar.dart';
import '../../widgets/marketplace/marketplace_empty_state.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final _searchController = TextEditingController();

  static const List<String> _categories = [
    'All',
    'CPU',
    'GPU',
    'RAM',
    'Motherboard',
    'Storage',
    'PSU',
    'Case',
    'Cooling',
    'Other',
  ];

  static const List<String> _conditions = ['All', 'New', 'Used'];

  @override
  void initState() {
    super.initState();
    // Delay until after the first frame completes to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;

        // Read category and search query from URL parameters
        final uri = GoRouterState.of(context).uri;
        final category = uri.queryParameters['category'] ?? '';
        final searchQuery = uri.queryParameters['search'] ?? '';

        final listingProvider = context.read<ListingProvider>();

        if (category.isNotEmpty) {
          listingProvider.setCategory(category);
        } else if (searchQuery.isNotEmpty) {
          _searchController.text = searchQuery;
          listingProvider.setSearchQuery(searchQuery);
        } else {
          listingProvider.fetchListings();
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Don't reload here to avoid setState during build
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listingProvider = context.watch<ListingProvider>();
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 768;

    // Cap columns between 1 and 5 to prevent layout crash at extreme widths
    final crossAxisCount = (screenWidth / 280).floor().clamp(1, 5);

    return Scaffold(
      appBar: const AppNavbar(),
      floatingActionButton: Visibility(
        visible: isLoggedIn,
        child: FloatingActionButton.extended(
          onPressed: () => context.go(AppRoutes.createListing),
          icon: const Icon(Icons.add),
          label: const Text('Sell a Part'),
          backgroundColor: AppColors.primary,
        ),
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          SearchFilterBar(
            searchController: _searchController,
            categories: _categories,
            conditions: _conditions,
            selectedCategory: listingProvider.selectedCategory,
            selectedCondition: listingProvider.selectedCondition,
            onSearchChanged: (val) =>
                context.read<ListingProvider>().setSearchQuery(val),
            onCategoryChanged: (val) =>
                context.read<ListingProvider>().setCategory(val!),
            onConditionChanged: (val) =>
                context.read<ListingProvider>().setCondition(val!),
            onClearFilters: () {
              _searchController.clear();
              context.read<ListingProvider>().clearFilters();
            },
          ),

          // Listings grid
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<ListingProvider>().fetchListings();
              },
              child: listingProvider.isLoading
                  ? const LoadingIndicator()
                  : listingProvider.errorMessage != null
                      ? ErrorMessage(message: listingProvider.errorMessage!)
                      : listingProvider.listings.isEmpty
                          ? const EmptyState()
                          : GridView.builder(
                              padding: EdgeInsets.all(isWide ? 24 : 12),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.72,
                              ),
                              itemCount: listingProvider.listings.length,
                              itemBuilder: (ctx, i) => ListingCard(
                                listing: listingProvider.listings[i],
                              ),
                            ),
            ),
          ),
        ],
      ),
    );
  }
}
