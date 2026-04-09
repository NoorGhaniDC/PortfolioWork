import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import 'input_formatters.dart';
import 'checkout_widgets.dart';

class PaymentForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController cardController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final TextEditingController? addressController;
  final TextEditingController? cityController;
  final TextEditingController? stateController;
  final TextEditingController? postalCodeController;
  final TextEditingController? countryController;
  final bool isProcessing;
  final VoidCallback onSubmit;

  const PaymentForm({
    required this.formKey,
    required this.nameController,
    required this.cardController,
    required this.expiryController,
    required this.cvvController,
    this.addressController,
    this.cityController,
    this.stateController,
    this.postalCodeController,
    this.countryController,
    required this.isProcessing,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Checkout',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Enter your payment details below',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),

          // Mock notice banner
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.warning, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'This is a demo checkout. No real payment will be processed.',
                    style: TextStyle(fontSize: 13, color: AppColors.warning),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Cardholder name
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading('Cardholder Information'),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name on Card',
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: 'Name as shown on your card',
                    ),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Please enter the cardholder name'
                        : null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Shipping address
          if (addressController != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeading('Shipping Address'),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Street Address',
                        prefixIcon: Icon(Icons.location_on_outlined),
                        hintText: 'Enter delivery address',
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Please enter street address'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cityController,
                            decoration: const InputDecoration(
                              labelText: 'City',
                              hintText: 'City for delivery',
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Please enter city'
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            controller: stateController,
                            decoration: const InputDecoration(
                              labelText: 'State',
                              hintText: 'State abbreviation',
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Please enter state'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: postalCodeController,
                            decoration: const InputDecoration(
                              labelText: 'Postal Code',
                              hintText: 'ZIP/Postal code for delivery',
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Please enter postal code'
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: countryController,
                            decoration: const InputDecoration(
                              labelText: 'Country',
                              hintText: 'Country for delivery',
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Please enter country'
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),

          // Card details
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading('Card Details'),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: cardController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberFormatter(),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      prefixIcon: Icon(Icons.credit_card_outlined),
                      hintText: '16-digit card number (no spaces)',
                    ),
                    validator: (v) {
                      final digits = v?.replaceAll(' ', '') ?? '';
                      if (digits.length != 16) {
                        return 'Please enter a valid 16-digit card number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: expiryController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            ExpiryFormatter(),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                            prefixIcon: Icon(Icons.calendar_month_outlined),
                            hintText: 'Card expiration date (MM/YY)',
                          ),
                          validator: (v) {
                            if (v == null || v.length != 5) {
                              return 'Enter MM/YY';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: '3-digit security code on back of card',
                          ),
                          validator: (v) {
                            if (v == null || v.length != 3) {
                              return 'Enter 3-digit CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Submit button
          SizedBox(
            height: 52,
            child: Tooltip(
              message: 'Process payment (demo mode - no actual transaction)',
              child: ElevatedButton(
                onPressed: isProcessing ? null : onSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: isProcessing
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Processing...', style: TextStyle(fontSize: 16)),
                        ],
                      )
                    : const Text('Complete Purchase',
                        style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Tooltip(
            message: 'Return to shopping cart to modify items',
            child: OutlinedButton(
              onPressed: isProcessing ? null : () => context.go(AppRoutes.cart),
              child: const Text('Back to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
