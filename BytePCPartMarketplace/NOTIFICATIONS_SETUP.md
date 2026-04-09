# Notifications System Setup Guide

## Overview

The notifications system has been implemented with Firebase Cloud Messaging (FCM) and Firestore. The system automatically creates notifications when:

1. **An item is sold** - Seller receives notification
2. **An item is purchased** - Buyer receives notification

## Files Added/Modified

### New Files Created

1. **`lib/models/notification_model.dart`**
   - `NotificationModel` class with fields: notificationId, userId, title, message, type, listingId, orderId, createdAt, isRead

2. **`lib/services/notification_service.dart`**
   - Handles Firebase Cloud Messaging setup
   - CRUD operations for notifications in Firestore
   - Real-time stream for notifications
   - Methods: `initializeMessaging()`, `getFCMToken()`, `createNotification()`, `getUserNotifications()`, etc.

3. **`lib/providers/notification_provider.dart`**
   - State management for notifications using Provider pattern
   - Properties: `notifications`, `unreadCount`, `notificationStream`
   - Methods: `initializeNotifications()`, `loadNotifications()`, `markAsRead()`, `deleteNotification()`, etc.

4. **`lib/screens/notifications/notifications_screen.dart`**
   - Full-featured notifications UI screen
   - Shows all notifications with mark as read, delete functionality
   - Real-time updates using Provider

### Modified Files

1. **`pubspec.yaml`**
   - Added: `firebase_messaging: ^15.1.0`

2. **`lib/main.dart`**
   - Added `NotificationProvider` import and to MultiProvider list

3. **`lib/services/order_service.dart`**
   - Updated `createOrder()` to:
     - Create notifications for seller and buyer
     - Mark listings as sold (inactive)
     - Save to users/{userId}/soldListings and purchasedListings subcollections
   - Added `getOrdersBySeller()` method

## Integration Steps

### 1. Initialize Notifications After User Login

In your auth provider or login screen after user authentication succeeds:

```dart
// After successful login
final notificationProvider = context.read<NotificationProvider>();
await notificationProvider.initializeNotifications(userId);
```

### 2. Add Notifications Screen to Navigation

Add route in your routing configuration:

```dart
GoRoute(
  path: '/notifications',
  builder: (context, state) => const NotificationsScreen(),
)
```

### 3. Add Notifications Button to Navbar

Add this in your navbar/app bar:

```dart
Consumer<NotificationProvider>(
  builder: (context, provider, _) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () => context.go('/notifications'),
        ),
        if (provider.unreadCount > 0)
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Text(
                '${provider.unreadCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  },
)
```

## Firebase Setup Requirements

### For Web

1. No special setup needed beyond existing Firebase configuration

### For Android

1. Ensure `google-services.json` is properly configured in `android/app/`
2. Your app's Firebase project must have Cloud Messaging enabled

### For iOS

1. Upload your Apple Push Notification certificate to Firebase console
2. Ensure `GoogleService-Info.plist` is configured

## Notification Types

The system supports these notification types:

- `'item_sold'` - Sent to seller when their item is purchased
- `'item_purchased'` - Sent to buyer when order is confirmed

You can add more types as needed by:

1. Creating the notification in notification_service.dart
2. Adding handling in the notifications_screen.dart UI

## Real-time Updates

Notifications update in real-time using Firestore streams. The `NotificationProvider` automatically listens for changes and updates the UI.

## Testing Notifications

To test notifications during development:

1. Create a test order through the normal checkout flow
2. You should see notifications created in Firestore under the `notifications` collection
3. The notifications screen will display them in real-time
4. Mark them as read to test the read/unread functionality

## Future Enhancements

Potential features to add:

1. Push notifications to user's device (actual OS notifications)
2. Notification preferences/filtering
3. Email notifications for important events
4. Grouped notifications by type
5. Notification actions (reply, view order, etc.)
