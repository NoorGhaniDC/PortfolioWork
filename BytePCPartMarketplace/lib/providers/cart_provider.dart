import 'package:flutter/material.dart';
import '../models/listing_model.dart';

/// A single item in the cart — wraps a listing.
class CartItem {
  final ListingModel listing;

  const CartItem({required this.listing});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get total =>
      _items.fold(0, (sum, item) => sum + item.listing.price);

  bool contains(String listingId) =>
      _items.any((item) => item.listing.listingId == listingId);

  /// Adds a listing to the cart. Does nothing if already present.
  void addItem(ListingModel listing) {
    if (contains(listing.listingId)) return;
    _items.add(CartItem(listing: listing));
    notifyListeners();
  }

  /// Removes a listing from the cart by ID.
  void removeItem(String listingId) {
    _items.removeWhere((item) => item.listing.listingId == listingId);
    notifyListeners();
  }

  /// Clears the entire cart.
  void clear() {
    _items.clear();
    notifyListeners();
  }
}