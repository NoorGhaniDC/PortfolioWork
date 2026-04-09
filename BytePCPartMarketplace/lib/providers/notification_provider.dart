import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  String? _currentUserId;
  List<NotificationModel> _notifications = [];
  Stream<List<NotificationModel>>? _notificationStream;

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;
  Stream<List<NotificationModel>>? get notificationStream =>
      _notificationStream;

  /// Initialize notifications for a user
  Future<void> initializeNotifications(String userId) async {
    _currentUserId = userId;
    await _notificationService.initializeMessaging();

    // Set up real-time stream
    _notificationStream = _notificationService.getNotificationsStream(userId);

    // Load initial notifications
    await loadNotifications();
    notifyListeners();
  }

  /// Load all notifications for current user
  Future<void> loadNotifications() async {
    if (_currentUserId == null) return;

    try {
      _notifications =
          await _notificationService.getUserNotifications(_currentUserId!);
      notifyListeners();
    } catch (e) {
      // Error loading notifications
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationService.markAsRead(notificationId);
      final index =
          _notifications.indexWhere((n) => n.notificationId == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
        notifyListeners();
      }
    } catch (e) {
      // Error marking notification as read
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    if (_currentUserId == null) return;

    try {
      await _notificationService.markAllAsRead(_currentUserId!);
      for (var i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
      notifyListeners();
    } catch (e) {
      // Error marking all as read
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _notificationService.deleteNotification(notificationId);
      _notifications.removeWhere((n) => n.notificationId == notificationId);
      notifyListeners();
    } catch (e) {
      // Error deleting notification
    }
  }

  /// Clear all notifications
  Future<void> clearAll() async {
    for (final notification in _notifications) {
      try {
        await _notificationService
            .deleteNotification(notification.notificationId);
      } catch (e) {
        // Error deleting notification
      }
    }
    _notifications.clear();
    notifyListeners();
  }

  /// Refresh notifications
  Future<void> refresh() async {
    await loadNotifications();
  }
}
