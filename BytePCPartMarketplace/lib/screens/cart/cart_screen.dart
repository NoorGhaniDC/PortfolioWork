import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/common/app_footer.dart';
import '../../widgets/cart/empty_cart.dart';
import '../../widgets/cart/cart_item_list.dart';
import '../../widgets/cart/order_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final authProvider = context.watch<AuthProvider>();
    final isWide = MediaQuery.of(context).size.width > 768;

    final currencyFormat =
        NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
      appBar: const AppNavbar(),
      body: cartProvider.items.isEmpty
          ? const EmptyCart()
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(isWide ? 40 : 16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Cart items list
                                  Expanded(
                                    flex: 3,
                                    child: CartItemList(
                                        currencyFormat: currencyFormat),
                                  ),
                                  const SizedBox(width: 32),
                                  // Order summary
                                  SizedBox(
                                    width: 300,
                                    child: OrderSummary(
                                      currencyFormat: currencyFormat,
                                      isLoggedIn: authProvider.isLoggedIn,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  CartItemList(currencyFormat: currencyFormat),
                                  const SizedBox(height: 24),
                                  OrderSummary(
                                    currencyFormat: currencyFormat,
                                    isLoggedIn: authProvider.isLoggedIn,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const AppFooter(),
                ],
              ),
            ),
    );
  }
}
