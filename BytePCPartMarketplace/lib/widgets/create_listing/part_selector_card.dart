import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/parts_catalog_provider.dart';
import '../../../widgets/common/loading_indicator.dart';
import 'create_listing_helpers.dart';

class PartSelectorCard extends StatelessWidget {
  final List<String> categories;
  final PartsCatalogProvider catalogProvider;

  const PartSelectorCard({
    super.key,
    required this.categories,
    required this.catalogProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionLabel(label: 'Select Your Part'),
            const SizedBox(height: 4),
            const Text(
              'Choose the category, manufacturer, and exact model',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Step 1 — Category
            const FieldLabel(label: 'Step 1 — Category'),
            DropdownButtonFormField<String>(
              initialValue: catalogProvider.selectedCategory,
              isExpanded: true,
              hint: const Text('Select a category'),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.category_outlined),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  context.read<PartsCatalogProvider>().selectCategory(v);
                }
              },
            ),

            // Step 2 — Manufacturer
            if (catalogProvider.selectedCategory != null) ...[
              const SizedBox(height: 20),
              const FieldLabel(label: 'Step 2 — Manufacturer'),
              catalogProvider.isLoadingManufacturers
                  ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: LoadingIndicator(),
              )
                  : DropdownButtonFormField<String>(
                initialValue: catalogProvider.selectedManufacturer,
                isExpanded: true,
                hint: const Text('Select a manufacturer'),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.business_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                items: catalogProvider.manufacturers
                    .map((m) =>
                    DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    context
                        .read<PartsCatalogProvider>()
                        .selectManufacturer(v);
                  }
                },
              ),
            ],

            // Step 3 — Model
            if (catalogProvider.selectedManufacturer != null) ...[
              const SizedBox(height: 20),
              const FieldLabel(label: 'Step 3 — Model'),
              catalogProvider.isLoadingModels
                  ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: LoadingIndicator(),
              )
                  : DropdownButtonFormField<String>(
                initialValue: catalogProvider.selectedPart?.partId,
                isExpanded: true,
                hint: const Text('Select a model'),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.memory_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                items: catalogProvider.models
                    .map((m) => DropdownMenuItem(
                    value: m.partId, child: Text(m.model)))
                    .toList(),
                onChanged: (partId) {
                  if (partId != null) {
                    final part = catalogProvider.models
                        .firstWhere((m) => m.partId == partId);
                    context
                        .read<PartsCatalogProvider>()
                        .selectModel(part);
                  }
                },
              ),
            ],

            if (catalogProvider.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                catalogProvider.errorMessage!,
                style:
                const TextStyle(color: AppColors.error, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }
}