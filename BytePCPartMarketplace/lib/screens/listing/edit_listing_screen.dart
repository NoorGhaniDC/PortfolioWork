import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../models/listing_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/listing_provider.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/create_listing/listing_image_picker.dart';
import '../../widgets/create_listing/edit_details_card.dart';
import '../../widgets/create_listing/part_info_card.dart';

class EditListingScreen extends StatefulWidget {
  final String listingId;
  const EditListingScreen({super.key, required this.listingId});

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();

  static const List<String> _conditions = ['New', 'Used'];
  String _selectedCondition = 'Used';

  // Image state
  List<Uint8List> _newImageBytes = [];
  List<String> _removedImageUrls = [];

  ListingModel? _listing;
  bool _isLoadingListing = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadListing());
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _loadListing() async {
    final authProvider = context.read<AuthProvider>();
    if (!authProvider.isLoggedIn) {
      context.go(AppRoutes.login);
      return;
    }

    final listingProvider = context.read<ListingProvider>();
    await listingProvider.fetchListingById(widget.listingId);
    final listing = listingProvider.selectedListing;

    if (!mounted) return;

    // Guard — only the seller can edit
    if (listing == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Listing not found.')),
      );
      context.go(AppRoutes.marketplace);
      return;
    }

    if (listing.sellerId != authProvider.currentUser!.userId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only edit your own listings.')),
      );
      context.go(AppRoutes.marketplace);
      return;
    }

    setState(() {
      _listing = listing;
      _priceController.text = listing.price.toStringAsFixed(2);
      _selectedCondition = listing.condition;
      _isLoadingListing = false;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_listing == null) return;

    // Must have at least one photo remaining
    final remainingExisting =
        _listing!.imageUrls.where((u) => !_removedImageUrls.contains(u)).length;
    if (remainingExisting + _newImageBytes.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please keep at least one photo.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final listingProvider = context.read<ListingProvider>();

    final updatedListing = _listing!.copyWith(
      price: double.parse(_priceController.text.trim()),
      condition: _selectedCondition,
    );

    final success = await listingProvider.updateListing(
      updatedListing,
      newImageBytesList: _newImageBytes.isNotEmpty ? _newImageBytes : null,
      removedImageUrls: _removedImageUrls.isNotEmpty ? _removedImageUrls : null,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Listing updated successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      context.go('/listing/${widget.listingId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingProvider = context.watch<ListingProvider>();

    if (_isLoadingListing) {
      return const Scaffold(
        appBar: AppNavbar(),
        body: LoadingIndicator(),
      );
    }

    final listing = _listing!;

    return Scaffold(
      appBar: const AppNavbar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                const Text(
                  'Edit Listing',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Update your listing details below',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 32),

                // Part info — read only, can't change the part on an edit
                PartInfoCard(
                  title: listing.title,
                  category: listing.category,
                ),
                const SizedBox(height: 16),

                // Photos
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: ListingImagePicker(
                      existingUrls: listing.imageUrls,
                      onImagesChanged: (newBytes, removedUrls) {
                        setState(() {
                          _newImageBytes = newBytes;
                          _removedImageUrls = removedUrls;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Listing details form
                EditDetailsCard(
                  formKey: _formKey,
                  priceController: _priceController,
                  selectedCondition: _selectedCondition,
                  conditions: _conditions,
                  isLoading: listingProvider.isLoading,
                  errorMessage: listingProvider.errorMessage,
                  onConditionChanged: (v) =>
                      setState(() => _selectedCondition = v!),
                  onSubmit: _submit,
                  listingId: widget.listingId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
