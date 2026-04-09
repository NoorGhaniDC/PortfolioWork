class NotificationModel {
  final String notificationId;
  final String userId;
  final String title;
  final String message;
  final String type; // 'item_sold', 'item_purchased', 'item_purchased_seller'
  final String? listingId;
  final String? orderId;
  final DateTime createdAt;
  final bool isRead;

  NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    this.listingId,
    this.orderId,
    required this.createdAt,
    this.isRead = false,
  });

  NotificationModel copyWith({
    bool? isRead,
  }) {
    return NotificationModel(
      notificationId: notificationId,
      userId: userId,
      title: title,
      message: message,
      type: type,
      listingId: listingId,
      orderId: orderId,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    // Handle createdAt as either string or Firestore Timestamp
    DateTime parsedDate;
    final dateValue = map['createdAt'];
    if (dateValue is String) {
      parsedDate = DateTime.parse(dateValue);
    } else if (dateValue != null &&
        dateValue.runtimeType.toString() == '_Timestamp') {
      parsedDate = (dateValue as dynamic).toDate() as DateTime;
    } else {
      parsedDate = DateTime.now();
    }

    return NotificationModel(
      notificationId: map['notificationId'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      type: map['type'] ?? 'item_sold',
      listingId: map['listingId'],
      orderId: map['orderId'],
      createdAt: parsedDate,
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'userId': userId,
      'title': title,
      'message': message,
      'type': type,
      'listingId': listingId,
      'orderId': orderId,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }
}
