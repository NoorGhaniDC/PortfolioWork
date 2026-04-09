class OrderModel {
  final String orderId;
  final String buyerId;
  final String buyerEmail;
  final String? buyerName;
  final List<OrderItem> items;
  final double total;
  final DateTime createdAt;
  final String status;
  final String? paymentMethod;
  final String? shippingAddress;
  final String? shippingCity;
  final String? shippingState;
  final String? shippingPostalCode;
  final String? shippingCountry;

  OrderModel({
    required this.orderId,
    required this.buyerId,
    required this.buyerEmail,
    required this.items,
    required this.total,
    required this.createdAt,
    this.status = 'completed',
    this.buyerName,
    this.paymentMethod,
    this.shippingAddress,
    this.shippingCity,
    this.shippingState,
    this.shippingPostalCode,
    this.shippingCountry,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'buyerId': buyerId,
      'buyerEmail': buyerEmail,
      'buyerName': buyerName,
      'items': items.map((i) => i.toMap()).toList(),
      'total': total,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress,
      'shippingCity': shippingCity,
      'shippingState': shippingState,
      'shippingPostalCode': shippingPostalCode,
      'shippingCountry': shippingCountry,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      buyerId: map['buyerId'] ?? '',
      buyerEmail: map['buyerEmail'] ?? '',
      buyerName: map['buyerName'],
      items: (map['items'] as List<dynamic>? ?? [])
          .map((i) => OrderItem.fromMap(i as Map<String, dynamic>))
          .toList(),
      total: (map['total'] ?? 0).toDouble(),
      createdAt: DateTime.parse(map['createdAt']),
      status: map['status'] ?? 'completed',
      paymentMethod: map['paymentMethod'],
      shippingAddress: map['shippingAddress'],
      shippingCity: map['shippingCity'],
      shippingState: map['shippingState'],
      shippingPostalCode: map['shippingPostalCode'],
      shippingCountry: map['shippingCountry'],
    );
  }
}

class OrderItem {
  final String listingId;
  final String title;
  final String category;
  final String condition;
  final double price;
  final String sellerId;

  OrderItem({
    required this.listingId,
    required this.title,
    required this.category,
    required this.condition,
    required this.price,
    required this.sellerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'listingId': listingId,
      'title': title,
      'category': category,
      'condition': condition,
      'price': price,
      'sellerId': sellerId,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      listingId: map['listingId'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      condition: map['condition'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      sellerId: map['sellerId'] ?? '',
    );
  }
}
