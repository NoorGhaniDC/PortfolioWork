import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/catalog/catalog_data/catalog_registry.dart';
import '/core/catalog/specs_schema.dart';
import '/models/listing_model.dart';

/// Generate description from part specs
String _generateDescription(Map<String, dynamic> partData) {
  final category = partData['category'] as String;
  final specs = partData['specs'] as Map<String, dynamic>?;

  if (specs == null) return 'No specifications available';

  final schemaFields = SpecsSchema.schema[category];
  if (schemaFields != null) {
    return schemaFields
        .where((f) => specs.containsKey(f.key))
        .map((f) => '${f.label}: ${f.type.format(specs[f.key])}')
        .join(' • ');
  }
  return specs.entries.map((e) => '${e.key}: ${e.value}').join(' • ');
}

/// Run ONCE to seed the parts_catalog collection in Firestore.
Future<void> seedPartsCatalog() async {
  final db = FirebaseFirestore.instance;
  final collection = db.collection('parts_catalog');

  var batch = db.batch();
  int count = 0;

  for (final part in allParts) {
    batch.set(collection.doc(), part);
    count++;
    if (count % 499 == 0) {
      await batch.commit();
      batch = db.batch();
    }
  }

  await batch.commit();
}

/// Backfills isActive and imageUrls on existing listing documents that
/// predate the ListingModel update. Run ONCE then remove the call.
Future<void> backfillListings() async {
  final db = FirebaseFirestore.instance;
  final snapshot = await db.collection('listings').get();
  var batch = db.batch();
  int count = 0;

  for (final doc in snapshot.docs) {
    final data = doc.data();
    final updates = <String, dynamic>{};
    if (data['isActive'] == null) updates['isActive'] = true;
    if (data['imageUrls'] == null) updates['imageUrls'] = [];

    if (updates.isNotEmpty) {
      batch.update(doc.reference, updates);
      count++;
      if (count % 499 == 0) {
        await batch.commit();
        batch = db.batch();
      }
    }
  }

  await batch.commit();
}

/// Seed sample listings for testing the marketplace.
/// Requires parts_catalog to be seeded first and a valid userId.
Future<void> seedListings(String userId) async {
  final db = FirebaseFirestore.instance;

  final cpuParts = await db
      .collection('parts_catalog')
      .where('category', isEqualTo: 'CPU')
      .limit(3)
      .get();

  final gpuParts = await db
      .collection('parts_catalog')
      .where('category', isEqualTo: 'GPU')
      .limit(3)
      .get();

  final ramParts = await db
      .collection('parts_catalog')
      .where('category', isEqualTo: 'RAM')
      .limit(2)
      .get();

  final storageParts = await db
      .collection('parts_catalog')
      .where('category', isEqualTo: 'Storage')
      .limit(2)
      .get();

  final sampleListings = <ListingModel>[];
  final now = DateTime.now();

  void addListing({
    required Map<String, dynamic> data,
    required String partId,
    required String category,
    required double price,
    required String condition,
    required Duration ago,
  }) {
    sampleListings.add(ListingModel(
      listingId: db.collection('listings').doc().id,
      title: '${data['manufacturer']} ${data['model']}',
      description: _generateDescription(data),
      price: price,
      condition: condition,
      sellerId: userId,
      partId: partId,
      category: category,
      createdAt: now.subtract(ago),
      imageUrls: const [],
      isActive: true,
    ));
  }

  // CPU listings
  if (cpuParts.docs.isNotEmpty) {
    addListing(
      data: cpuParts.docs[0].data(),
      partId: cpuParts.docs[0].id,
      category: 'CPU',
      price: 299.99,
      condition: 'New',
      ago: const Duration(days: 2),
    );
  }
  if (cpuParts.docs.length > 1) {
    addListing(
      data: cpuParts.docs[1].data(),
      partId: cpuParts.docs[1].id,
      category: 'CPU',
      price: 199.99,
      condition: 'Used',
      ago: const Duration(hours: 12),
    );
  }

  // GPU listings
  if (gpuParts.docs.isNotEmpty) {
    addListing(
      data: gpuParts.docs[0].data(),
      partId: gpuParts.docs[0].id,
      category: 'GPU',
      price: 899.99,
      condition: 'Used',
      ago: const Duration(days: 5),
    );
  }
  if (gpuParts.docs.length > 1) {
    addListing(
      data: gpuParts.docs[1].data(),
      partId: gpuParts.docs[1].id,
      category: 'GPU',
      price: 649.99,
      condition: 'New',
      ago: const Duration(hours: 6),
    );
  }
  if (gpuParts.docs.length > 2) {
    addListing(
      data: gpuParts.docs[2].data(),
      partId: gpuParts.docs[2].id,
      category: 'GPU',
      price: 199.99,
      condition: 'Used',
      ago: const Duration(days: 1),
    );
  }

  // RAM listings
  if (ramParts.docs.isNotEmpty) {
    addListing(
      data: ramParts.docs[0].data(),
      partId: ramParts.docs[0].id,
      category: 'RAM',
      price: 89.99,
      condition: 'Used',
      ago: const Duration(hours: 18),
    );
  }
  if (ramParts.docs.length > 1) {
    addListing(
      data: ramParts.docs[1].data(),
      partId: ramParts.docs[1].id,
      category: 'RAM',
      price: 129.99,
      condition: 'New',
      ago: const Duration(hours: 3),
    );
  }

  // Storage listings
  if (storageParts.docs.isNotEmpty) {
    addListing(
      data: storageParts.docs[0].data(),
      partId: storageParts.docs[0].id,
      category: 'Storage',
      price: 79.99,
      condition: 'Used',
      ago: const Duration(days: 3),
    );
  }
  if (storageParts.docs.length > 1) {
    addListing(
      data: storageParts.docs[1].data(),
      partId: storageParts.docs[1].id,
      category: 'Storage',
      price: 139.99,
      condition: 'New',
      ago: const Duration(hours: 8),
    );
  }

  final batch = db.batch();
  for (final listing in sampleListings) {
    batch.set(
      db.collection('listings').doc(listing.listingId),
      listing.toMap(),
    );
  }

  await batch.commit();
}
