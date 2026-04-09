import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../models/order_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/listing_provider.dart';
import '../../services/order_service.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/checkout/checkout_layout.dart';
import '../../widgets/checkout/order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final OrderService _orderService = OrderService();

  bool _isProcessing = false;
  bool _isComplete = false;
  String _orderId = '';
  late OrderModel _orderData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      if (!authProvider.isLoggedIn) {
        context.go(AppRoutes.login);
      }

      final cart = context.read<CartProvider>();
      if (cart.items.isEmpty) {
        context.go(AppRoutes.cart);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    final cart = context.read<CartProvider>();
    final listingProvider = context.read<ListingProvider>();
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.currentUser!;

    try {
      // Generate order ID
      _orderId =
          'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      // Build order model
      final order = OrderModel(
        orderId: _orderId,
        buyerId: user.userId,
        buyerEmail: user.email,
        buyerName: _nameController.text,
        items: cart.items
            .map((item) => OrderItem(
                  listingId: item.listing.listingId,
                  title: item.listing.title,
                  category: item.listing.category,
                  condition: item.listing.condition,
                  price: item.listing.price,
                  sellerId: item.listing.sellerId,
                ))
            .toList(),
        total: cart.total,
        createdAt: DateTime.now(),
        paymentMethod: 'Credit Card',
        shippingAddress: _addressController.text,
        shippingCity: _cityController.text,
        shippingState: _stateController.text,
        shippingPostalCode: _postalCodeController.text,
        shippingCountry: _countryController.text,
      );
      _orderData = order;

      // Write order to Firestore — triggers Cloud Function to send invoice email
      await _orderService.createOrder(_orderData);

      // Complete the sales: move items to purchasedListings and soldListings
      for (final item in cart.items) {
        final success = await listingProvider.completeSale(
          item.listing.listingId,
          item.listing.sellerId,
          user.userId,
          item.listing,
        );
        if (!success) {
          throw listingProvider.errorMessage ?? 'Failed to complete sale';
        }
      }

      // Clear the cart
      cart.clear();

      setState(() {
        _isProcessing = false;
        _isComplete = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order failed: ${e.toString()}'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
          ),
        );
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isComplete)
      return OrderConfirmationScreen(orderId: _orderId, orderData: _orderData);

    final cart = context.watch<CartProvider>();
    final isWide = MediaQuery.of(context).size.width > 768;
    final currencyFormat =
        NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
      appBar: const AppNavbar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isWide ? 40 : 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: CheckoutLayout(
              isWide: isWide,
              cart: cart,
              currencyFormat: currencyFormat,
              formKey: _formKey,
              nameController: _nameController,
              cardController: _cardController,
              expiryController: _expiryController,
              cvvController: _cvvController,
              addressController: _addressController,
              cityController: _cityController,
              stateController: _stateController,
              postalCodeController: _postalCodeController,
              countryController: _countryController,
              isProcessing: _isProcessing,
              onSubmit: _submitOrder,
            ),
          ),
        ),
      ),
    );
  }
}
