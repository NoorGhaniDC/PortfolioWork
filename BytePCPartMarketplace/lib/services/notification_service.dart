import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';
import '../models/notification_model.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final String _collection = 'notifications';

  /// Initialize Firebase Cloud Messaging
  Future<void> initializeMessaging() async {
    try {
      // Request user permission for notifications
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((message) {
        if (message.notification != null) {
          // Notification received while app is in foreground
        }
      });

      // Handle background messages
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        // Message opened when app was closed
      });
    } catch (e) {
      // Error initializing messaging
    }
  }

  /// Get FCM token for the user
  Future<String?> getFCMToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      return null;
    }
  }

  /// Create and store a notification in Firestore
  Future<NotificationModel> createNotification({
    required String userId,
    required String title,
    required String message,
    required String type,
    String? listingId,
    String? orderId,
  }) async {
    try {
      final notification = NotificationModel(
        notificationId: const Uuid().v4(),
        userId: userId,
        title: title,
        message: message,
        type: type,
        listingId: listingId,
        orderId: orderId,
        createdAt: DateTime.now(),
        isRead: false,
      );

      await _firestore
          .collection(_collection)
          .doc(notification.notificationId)
          .set(notification.toMap());

      return notification;
    } catch (e) {
      throw 'Failed to create notification: $e';
    }
  }

  /// Get all notifications for a user
  Future<List<NotificationModel>> getUserNotifications(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => NotificationModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw 'Failed to load notifications: $e';
    }
  }

  /// Get unread notifications for a user
  Future<List<NotificationModel>> getUnreadNotifications(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => NotificationModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw 'Failed to load unread notifications: $e';
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      throw 'Failed to mark notification as read: $e';
    }
  }

  /// Mark all notifications as read for a user
  Future<void> markAllAsRead(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.update({'isRead': true});
      }
    } catch (e) {
      throw 'Failed to mark all notifications as read: $e';
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firestore.collection(_collection).doc(notificationId).delete();
    } catch (e) {
      throw 'Failed to delete notification: $e';
    }
  }

  /// Stream of notifications for real-time updates
  Stream<List<NotificationModel>> getNotificationsStream(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromMap(doc.data()))
            .toList());
  }
}
