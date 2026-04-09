import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../widgets/common/loading_indicator.dart';
import 'create_listing_helpers.dart';

class EditDetailsCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController priceController;
  final String selectedCondition;
  final List<String> conditions;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<String?> onConditionChanged;
  final VoidCallback onSubmit;
  final String listingId;

  const EditDetailsCard({
    required this.formKey,
    required this.priceController,
    required this.selectedCondition,
    required this.conditions,
    required this.isLoading,
    required this.errorMessage,
    required this.onConditionChanged,
    required this.onSubmit,
    required this.listingId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionLabel(label: 'Listing Details'),
              const SizedBox(height: 16),

              const FieldLabel(label: 'Condition'),
              DropdownButtonFormField<String>(
                initialValue: selectedCondition,
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.star_outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                items: conditions
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: onConditionChanged,
              ),
              const SizedBox(height: 20),

              const FieldLabel(label: 'Price (USD)'),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter listing price in USD',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: Validators.price,
              ),
              const SizedBox(height: 32),

              // Error message
              if (errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.error),
                  ),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: AppColors.error),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Action buttons
              isLoading
                  ? const LoadingIndicator()
                  : Row(
                      children: [
                        Expanded(
                          child: Tooltip(
                            message: 'Discard changes and return to listing',
                            child: OutlinedButton(
                              onPressed: () =>
                                  context.go('/listing/$listingId'),
                              child: const Text('Cancel'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Tooltip(
                            message:
                                'Update listing with new price and condition',
                            child: ElevatedButton.icon(
                              onPressed: onSubmit,
                              icon: const Icon(Icons.save_outlined),
                              label: const Text(
                                'Save Changes',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
