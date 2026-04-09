class PartsCatalogModel {
  final String partId;
  final String category;
  final String manufacturer;
  final String model;
  final Map<String, dynamic> specs;

  PartsCatalogModel({
    required this.partId,
    required this.category,
    required this.manufacturer,
    required this.model,
    required this.specs,
  });

  factory PartsCatalogModel.fromMap(String id, Map<String, dynamic> map) {
    return PartsCatalogModel(
      partId: id,
      category: map['category'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      model: map['model'] ?? '',
      specs: Map<String, dynamic>.from(map['specs'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'manufacturer': manufacturer,
      'model': model,
      'specs': specs,
    };
  }

  /// Human-readable display label
  String get displayName => '$manufacturer $model';
}