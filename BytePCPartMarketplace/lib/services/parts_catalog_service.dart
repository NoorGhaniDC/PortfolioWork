import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/parts_catalog_model.dart';

class PartsCatalogService {
  final _db = FirebaseFirestore.instance;
  static const _collection = 'parts_catalog';

  /// Fetch all distinct manufacturers for a given category
  Future<List<String>> getManufacturers(String category) async {
    final snapshot = await _db
        .collection(_collection)
        .where('category', isEqualTo: category)
        .get();

    final manufacturers = snapshot.docs
        .map((d) => d.data()['manufacturer'] as String)
        .toSet()
        .toList()
      ..sort();

    return manufacturers;
  }

  /// Fetch all models for a given category + manufacturer
  Future<List<PartsCatalogModel>> getModels(
      String category, String manufacturer) async {
    final snapshot = await _db
        .collection(_collection)
        .where('category', isEqualTo: category)
        .where('manufacturer', isEqualTo: manufacturer)
        .orderBy('model')
        .get();

    return snapshot.docs
        .map((d) => PartsCatalogModel.fromMap(d.id, d.data()))
        .toList();
  }

  /// Fetch a single part by ID
  Future<PartsCatalogModel?> getPartById(String partId) async {
    final doc = await _db.collection(_collection).doc(partId).get();
    if (!doc.exists) return null;
    return PartsCatalogModel.fromMap(doc.id, doc.data()!);
  }
}