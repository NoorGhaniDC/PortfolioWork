class ListingModel {
  final String listingId;
  final String title;
  final String description;
  final double price;
  final String condition;
  final String sellerId;
  final String partId;
  final String category;
  final DateTime createdAt;
  final List<String> imageUrls;
  final bool isActive;

  ListingModel({
    required this.listingId,
    required this.title,
    required this.description,
    required this.price,
    required this.condition,
    required this.sellerId,
    required this.partId,
    required this.category,
    required this.createdAt,
    this.imageUrls = const [],
    this.isActive = true,
  });

  ListingModel copyWith({
    String? title,
    String? description,
    double? price,
    String? condition,
    List<String>? imageUrls,
    bool? isActive,
  }) {
    return ListingModel(
      listingId: listingId,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      condition: condition ?? this.condition,
      sellerId: sellerId,
      partId: partId,
      category: category,
      createdAt: createdAt,
      imageUrls: imageUrls ?? this.imageUrls,
      isActive: isActive ?? this.isActive,
    );
  }

  factory ListingModel.fromMap(Map<String, dynamic> map) {
    // Handle createdAt as either string or Firestore Timestamp
    DateTime parsedDate;
    final dateValue = map['createdAt'];
    if (dateValue is String) {
      parsedDate = DateTime.parse(dateValue);
    } else if (dateValue != null &&
        dateValue.runtimeType.toString() == '_Timestamp') {
      // Firestore Timestamp object
      parsedDate = (dateValue as dynamic).toDate() as DateTime;
    } else {
      // Fallback to current time
      parsedDate = DateTime.now();
    }

    return ListingModel(
      listingId: map['listingId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      condition: map['condition'] ?? 'Used',
      sellerId: map['sellerId'] ?? '',
      partId: map['partId'] ?? '',
      category: map['category'] ?? '',
      createdAt: parsedDate,
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listingId': listingId,
      'title': title,
      'description': description,
      'price': price,
      'condition': condition,
      'sellerId': sellerId,
      'partId': partId,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'imageUrls': imageUrls,
      'isActive': isActive,
    };
  }
}
