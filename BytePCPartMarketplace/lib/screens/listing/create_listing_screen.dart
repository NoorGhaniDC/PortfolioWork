import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/catalog/specs_schema.dart';
import '../../models/listing_model.dart';
import '../../models/parts_catalog_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/listing_provider.dart';
import '../../providers/parts_catalog_provider.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/create_listing/part_selector_card.dart';
import '../../widgets/create_listing/specs_preview_card.dart';
import '../../widgets/create_listing/listing_image_picker.dart';
import '../../widgets/create_listing/listing_details_card.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();

  static final List<String> _categories = SpecsSchema.schema.keys.toList();
  static const List<String> _conditions = ['New', 'Used'];
  String _selectedCondition = 'Used';

  // Image state
  List<Uint8List> _imageBytes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isLoggedIn = context.read<AuthProvider>().isLoggedIn;
      if (!isLoggedIn) context.go(AppRoutes.login);
      context.read<PartsCatalogProvider>().reset();
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  String _generateDescription(PartsCatalogModel part) {
    final schemaFields = SpecsSchema.schema[part.category];
    if (schemaFields != null) {
      return schemaFields
          .where((f) => part.specs.containsKey(f.key))
          .map((f) => '${f.label}: ${f.type.format(part.specs[f.key])}')
          .join(' • ');
    }
    return part.specs.entries.map((e) => '${e.key}: ${e.value}').join(' • ');
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final catalogProvider = context.read<PartsCatalogProvider>();
    if (!catalogProvider.isPartSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category, manufacturer, and model.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final listingProvider = context.read<ListingProvider>();
    final selectedPart = catalogProvider.selectedPart!;

    final listing = ListingModel(
      listingId: const Uuid().v4(),
      title: selectedPart.displayName,
      description: _generateDescription(selectedPart),
      price: double.parse(_priceController.text.trim()),
      condition: _selectedCondition,
      sellerId: authProvider.currentUser!.userId,
      partId: selectedPart.partId,
      category: selectedPart.category,
      createdAt: DateTime.now(),
    );

    final success = await listingProvider.createListing(listing, _imageBytes);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Listing created successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      context.read<PartsCatalogProvider>().reset();
      context.go('/listing/${listing.listingId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingProvider = context.watch<ListingProvider>();
    final catalogProvider = context.watch<PartsCatalogProvider>();

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
                  'Create a Listing',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Fill in the details below to list your part for sale',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 32),

                // Steps 1–3: Part selector
                PartSelectorCard(
                  categories: _categories,
                  catalogProvider: catalogProvider,
                ),
                const SizedBox(height: 16),

                // Specs preview — shown once a model is selected
                if (catalogProvider.selectedPart != null) ...[
                  SpecsPreviewCard(part: catalogProvider.selectedPart!),
                  const SizedBox(height: 16),
                ],

                // Photos
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: ListingImagePicker(
                      onImagesChanged: (newBytes, _) {
                        setState(() => _imageBytes = newBytes);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Listing details form
                ListingDetailsCard(
                  formKey: _formKey,
                  priceController: _priceController,
                  selectedCondition: _selectedCondition,
                  conditions: _conditions,
                  isLoading: listingProvider.isLoading,
                  errorMessage: listingProvider.errorMessage,
                  onConditionChanged: (v) =>
                      setState(() => _selectedCondition = v!),
                  onSubmit: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
