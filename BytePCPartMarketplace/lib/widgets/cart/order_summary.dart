import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../providers/cart_provider.dart';

class OrderSummary extends StatelessWidget {
  final NumberFormat currencyFormat;
  final bool isLoggedIn;

  const OrderSummary({
    required this.currencyFormat,
    required this.isLoggedIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // Line items
            ...cartProvider.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.listing.title,
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        currencyFormat.format(item.listing.price),
                        style: const TextStyle(
                            color: AppColors.textPrimary, fontSize: 13),
                      ),
                    ],
                  ),
                )),

            const Divider(),
            const SizedBox(height: 12),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  currencyFormat.format(cartProvider.total),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Checkout button
            Tooltip(
              message: 'Review shipping address and payment information',
              child: ElevatedButton(
                onPressed: () {
                  if (!isLoggedIn) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Login Required'),
                        content: const Text(
                            'You need to be logged in to proceed to checkout.'),
                        actions: [
                          Tooltip(
                            message: 'Close this dialog',
                            child: TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Cancel'),
                            ),
                          ),
                          Tooltip(
                            message: 'Sign in to your account to proceed',
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                context.go(AppRoutes.login);
                              },
                              child: const Text('Log In'),
                            ),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  context.go(AppRoutes.checkout);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Continue shopping
            Tooltip(
              message: 'Return to marketplace to add more items',
              child: OutlinedButton(
                onPressed: () => context.go(AppRoutes.marketplace),
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
