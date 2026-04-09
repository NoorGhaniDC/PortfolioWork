import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';
import 'notification_service.dart';
import 'listing_service.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationService _notificationService = NotificationService();
  final ListingService _listingService = ListingService();
  final String _collection = 'orders';

  /// Writes the completed order to Firestore.
  /// The Cloud Function listens to this collection and sends the invoice email.
  /// Notifications and subcollection writes are optional and non-blocking.
  Future<void> createOrder(OrderModel order) async {
    try {
      // CRITICAL: Save the order first - this must succeed
      await _firestore
          .collection(_collection)
          .doc(order.orderId)
          .set(order.toMap());

      // Process each item in the order (non-blocking - errors won't affect order)
      for (final item in order.items) {
        // Try to mark listing as sold
        try {
          await _listingService.markAsSold(item.listingId, item.sellerId);
        } catch (e) {
          // Could not mark listing as sold
        }

        // Try to save to seller's soldListings subcollection
        try {
          await _firestore
              .collection('users')
              .doc(item.sellerId)
              .collection('soldListings')
              .doc(item.listingId)
              .set({
            'listing': {
              'listingId': item.listingId,
              'title': item.title,
              'category': item.category,
              'condition': item.condition,
              'price': item.price,
            },
            'soldTo': order.buyerId,
            'soldDate': DateTime.now().toIso8601String(),
            'orderId': order.orderId,
          });
        } catch (e) {
          // Could not save to soldListings
        }

        // Try to create notification for seller (non-blocking)
        try {
          await _notificationService.createNotification(
            userId: item.sellerId,
            title: 'Item Sold!',
            message: '${item.title} has been sold for \$${item.price}',
            type: 'item_sold',
            listingId: item.listingId,
            orderId: order.orderId,
          );
        } catch (e) {
          // Could not create seller notification
        }
      }

      // Try to save to buyer's purchasedListings subcollection
      for (final item in order.items) {
        try {
          await _firestore
              .collection('users')
              .doc(order.buyerId)
              .collection('purchasedListings')
              .doc(item.listingId)
              .set({
            'listing': {
              'listingId': item.listingId,
              'title': item.title,
              'category': item.category,
              'condition': item.condition,
              'price': item.price,
            },
            'soldBy': item.sellerId,
            'purchaseDate': DateTime.now().toIso8601String(),
            'orderId': order.orderId,
          });
        } catch (e) {
          // Could not save to purchasedListings
        }
      }

      // Try to create notification for buyer (non-blocking)
      try {
        await _notificationService.createNotification(
          userId: order.buyerId,
          title: 'Purchase Confirmed!',
          message:
              'Your order has been confirmed. Total: \$${order.total.toStringAsFixed(2)}',
          type: 'item_purchased',
          orderId: order.orderId,
        );
      } catch (e) {
        // Could not create buyer notification
      }
    } catch (e) {
      throw 'Failed to save order: $e';
    }
  }

  /// Fetches all orders for a given buyer.
  Future<List<OrderModel>> getOrdersByBuyer(String buyerId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('buyerId', isEqualTo: buyerId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw 'Failed to load orders: $e';
    }
  }

  /// Fetches all orders where user is the seller.
  Future<List<OrderModel>> getOrdersBySeller(String sellerId) async {
    try {
      final snapshot = await _firestore.collection(_collection).get();

      final allOrders =
          snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();

      // Filter orders where any item is sold by this seller
      return allOrders
          .where(
              (order) => order.items.any((item) => item.sellerId == sellerId))
          .toList();
    } catch (e) {
      throw 'Failed to load seller orders: $e';
    }
  }
}
