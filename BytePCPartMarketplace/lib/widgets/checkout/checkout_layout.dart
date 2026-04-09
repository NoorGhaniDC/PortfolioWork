import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/checkout/payment_form.dart';
import '../../widgets/checkout/checkout_summary.dart';

class CheckoutLayout extends StatelessWidget {
  final bool isWide;
  final CartProvider cart;
  final NumberFormat currencyFormat;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController cardController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postalCodeController;
  final TextEditingController countryController;
  final bool isProcessing;
  final VoidCallback onSubmit;

  const CheckoutLayout({
    required this.isWide,
    required this.cart,
    required this.currencyFormat,
    required this.formKey,
    required this.nameController,
    required this.cardController,
    required this.expiryController,
    required this.cvvController,
    required this.addressController,
    required this.cityController,
    required this.stateController,
    required this.postalCodeController,
    required this.countryController,
    required this.isProcessing,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isWide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: PaymentForm(
                  formKey: formKey,
                  nameController: nameController,
                  cardController: cardController,
                  expiryController: expiryController,
                  cvvController: cvvController,
                  addressController: addressController,
                  cityController: cityController,
                  stateController: stateController,
                  postalCodeController: postalCodeController,
                  countryController: countryController,
                  isProcessing: isProcessing,
                  onSubmit: onSubmit,
                ),
              ),
              const SizedBox(width: 32),
              SizedBox(
                width: 300,
                child: CheckoutSummary(
                  cart: cart,
                  currencyFormat: currencyFormat,
                ),
              ),
            ],
          )
        : Column(
            children: [
              CheckoutSummary(
                cart: cart,
                currencyFormat: currencyFormat,
              ),
              const SizedBox(height: 24),
              PaymentForm(
                formKey: formKey,
                nameController: nameController,
                cardController: cardController,
                expiryController: expiryController,
                cvvController: cvvController,
                addressController: addressController,
                cityController: cityController,
                stateController: stateController,
                postalCodeController: postalCodeController,
                countryController: countryController,
                isProcessing: isProcessing,
                onSubmit: onSubmit,
              ),
            ],
          );
  }
}
