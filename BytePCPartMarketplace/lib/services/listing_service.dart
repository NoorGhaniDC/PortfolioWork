import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/listing_model.dart';
import 'storage_service.dart';

class ListingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  final String _collection = 'listings';

  // ── Read ─────────────────────────────────────────────────────────────────

  Future<List<ListingModel>> getListings({
    String? category,
    String? condition,
    double? maxPrice,
    String? searchQuery,
  }) async {
    try {
      Query query = _firestore
          .collection(_collection)
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true);

      if (category != null && category != 'All') {
        query = query.where('category', isEqualTo: category);
      }
      if (condition != null && condition != 'All') {
        query = query.where('condition', isEqualTo: condition);
      }
      if (maxPrice != null) {
        query = query.where('price', isLessThanOrEqualTo: maxPrice);
      }

      final snapshot = await query.get();
      final listings = snapshot.docs
          .map(
              (doc) => ListingModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      if (searchQuery != null && searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return listings
            .where((l) =>
                l.category.toLowerCase().contains(query) ||
                l.title.toLowerCase().contains(query) ||
                l.description.toLowerCase().contains(query))
            .toList();
      }

      return listings;
    } catch (e) {
      throw 'Failed to load listings: $e';
    }
  }

  Future<ListingModel?> getListingById(String listingId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(listingId).get();
      if (doc.exists) return ListingModel.fromMap(doc.data()!);
      return null;
    } catch (e) {
      throw 'Failed to load listing: $e';
    }
  }

  Future<List<ListingModel>> getListingsBySeller(String sellerId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('sellerId', isEqualTo: sellerId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => ListingModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw 'Failed to load your listings: $e';
    }
  }

  // ── Create ────────────────────────────────────────────────────────────────

  /// Uploads images then writes the listing to Firestore.
  /// Also saves to users/{userId}/listedListings subcollection.
  /// Returns the saved listing with [imageUrls] populated.
  Future<ListingModel> createListing(
    ListingModel listing,
    List<Uint8List> imageBytesList,
  ) async {
    try {
      List<String> imageUrls = [];
      if (imageBytesList.isNotEmpty) {
        imageUrls = await _storageService.uploadListingImages(
          listing.listingId,
          imageBytesList,
        );
      }

      final listingWithImages = listing.copyWith(imageUrls: imageUrls);
      final listingMap = listingWithImages.toMap();

      // Save to main collection
      await _firestore
          .collection(_collection)
          .doc(listing.listingId)
          .set(listingMap);

      // Also save to user's listedListings subcollection
      await _firestore
          .collection('users')
          .doc(listing.sellerId)
          .collection('listedListings')
          .doc(listing.listingId)
          .set(listingMap);

      return listingWithImages;
    } catch (e) {
      await _storageService.deleteListingImages(listing.listingId);
      throw 'Failed to create listing: $e';
    }
  }

  // ── Update ────────────────────────────────────────────────────────────────

  /// Updates listing fields, optionally adding new images or removing existing ones.
  /// Also updates in user's listedListings subcollection.
  Future<ListingModel> updateListing(
    ListingModel listing, {
    List<Uint8List>? newImageBytesList,
    List<String>? removedImageUrls,
  }) async {
    try {
      List<String> updatedUrls = List.from(listing.imageUrls);

      if (removedImageUrls != null && removedImageUrls.isNotEmpty) {
        await _storageService.deleteImagesByUrls(removedImageUrls);
        updatedUrls.removeWhere((url) => removedImageUrls.contains(url));
      }

      if (newImageBytesList != null && newImageBytesList.isNotEmpty) {
        final newUrls = await _storageService.uploadListingImages(
          listing.listingId,
          newImageBytesList,
        );
        updatedUrls.addAll(newUrls);
      }

      final updated = listing.copyWith(imageUrls: updatedUrls);
      final updatedMap = updated.toMap();

      // Update main collection
      await _firestore
          .collection(_collection)
          .doc(listing.listingId)
          .update(updatedMap);

      // Update user's listedListings subcollection
      await _firestore
          .collection('users')
          .doc(listing.sellerId)
          .collection('listedListings')
          .doc(listing.listingId)
          .update(updatedMap);

      return updated;
    } catch (e) {
      throw 'Failed to update listing: $e';
    }
  }

  /// Marks a listing as sold — removes it from the marketplace
  /// without deleting the record.
  Future<void> markAsSold(String listingId, String sellerId) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(listingId)
          .update({'isActive': false});
    } catch (e) {
      throw 'Failed to mark listing as sold: $e';
    }
  }

  // ── Subcollection Methods ─────────────────────────────────────────────────

  /// Gets user's active listed listings from users/{userId}/listedListings
  Future<List<ListingModel>> getUserListedListings(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('listedListings')
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => ListingModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw 'Failed to load your listings: $e';
    }
  }

  /// Gets user's sold listings from users/{userId}/soldListings
  /// Returns map with listing data, soldTo, and soldDate
  Future<List<Map<String, dynamic>>> getUserSoldListings(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('soldListings')
          .get();
      final docs = snapshot.docs.map((doc) => doc.data()).toList();
      return _sortByDateField(docs, 'soldDate');
    } catch (e) {
      throw 'Failed to load your sold listings: $e';
    }
  }

  /// Gets user's purchased listings from users/{userId}/purchasedListings
  /// Returns map with listing data, soldBy, and purchaseDate
  Future<List<Map<String, dynamic>>> getUserPurchasedListings(
      String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('purchasedListings')
          .get();
      final docs = snapshot.docs.map((doc) => doc.data()).toList();
      return _sortByDateField(docs, 'purchaseDate');
    } catch (e) {
      throw 'Failed to load your purchases: $e';
    }
  }

  /// Gets user's wishlist from users/{userId}/wishlist
  /// Returns map with listing snapshot and dateAdded
  Future<List<Map<String, dynamic>>> getUserWishlist(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .get();
      final docs = snapshot.docs.map((doc) => doc.data()).toList();

      // Fetch current isActive status from main listings for each wishlisted item
      final updatedDocs = <Map<String, dynamic>>[];
      for (var doc in docs) {
        final listingId = doc['listingId'] as String?;
        if (listingId != null) {
          try {
            final mainListing =
                await _firestore.collection('listings').doc(listingId).get();
            if (mainListing.exists) {
              // Update with current isActive status
              doc['isActive'] = mainListing.data()?['isActive'] ?? true;
            }
          } catch (e) {
            // Keep the stored isActive if fetch fails
          }
        }
        updatedDocs.add(doc);
      }

      return _sortByDateField(updatedDocs, 'dateAdded');
    } catch (e) {
      throw 'Failed to load your wishlist: $e';
    }
  }

  /// Adds a listing to user's wishlist
  Future<void> addToWishlist(
      String userId, String listingId, ListingModel listing) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(listingId)
          .set({
        ...listing.toMap(),
        'dateAdded': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Failed to add to wishlist: $e';
    }
  }

  /// Removes a listing from user's wishlist
  Future<void> removeFromWishlist(String userId, String listingId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(listingId)
          .delete();
    } catch (e) {
      throw 'Failed to remove from wishlist: $e';
    }
  }

  // ── Helper Methods ───────────────────────────────────────────────────────

  /// Sorts a list of maps by a date field (descending).
  /// Handles both Firestore Timestamps and DateTime strings.
  List<Map<String, dynamic>> _sortByDateField(
    List<Map<String, dynamic>> docs,
    String dateField,
  ) {
    docs.sort((a, b) {
      final dateA = a[dateField] as dynamic;
      final dateB = b[dateField] as dynamic;
      if (dateA == null || dateB == null) return 0;
      try {
        final timeA = dateA.runtimeType.toString() == '_Timestamp'
            ? (dateA as dynamic).toDate() as DateTime
            : DateTime.parse(dateA.toString());
        final timeB = dateB.runtimeType.toString() == '_Timestamp'
            ? (dateB as dynamic).toDate() as DateTime
            : DateTime.parse(dateB.toString());
        return timeB.compareTo(timeA); // Descending
      } catch (e) {
        return 0;
      }
    });
    return docs;
  }

  /// Removes a listing from ALL users' wishlists (called when item is sold)
  Future<void> removeFromAllWishlists(String listingId) async {
    try {
      final usersSnapshot = await _firestore.collection('users').get();

      for (var userDoc in usersSnapshot.docs) {
        await _firestore
            .collection('users')
            .doc(userDoc.id)
            .collection('wishlist')
            .doc(listingId)
            .delete()
            .catchError((_) {
          // Silently ignore if doesn't exist
        });
      }
    } catch (e) {
      throw 'Failed to remove from all wishlists: $e';
    }
  }

  /// Moves a listing from listedListings to soldListings for seller
  /// and adds to purchasedListings for buyer
  Future<void> completeSale(
    String listingId,
    String sellerId,
    String buyerId,
    ListingModel listing,
  ) async {
    try {
      final now = FieldValue.serverTimestamp();

      // 1. Move to seller's soldListings
      await _firestore
          .collection('users')
          .doc(sellerId)
          .collection('soldListings')
          .doc(listingId)
          .set({
        ...listing.toMap(),
        'soldTo': buyerId,
        'soldDate': now,
      });

      // 2. Remove from seller's listedListings
      await _firestore
          .collection('users')
          .doc(sellerId)
          .collection('listedListings')
          .doc(listingId)
          .delete();

      // 3. Add to buyer's purchasedListings
      final purchaseData = {
        ...listing.toMap(),
        'soldBy': sellerId,
        'purchaseDate': now,
      };
      await _firestore
          .collection('users')
          .doc(buyerId)
          .collection('purchasedListings')
          .doc(listingId)
          .set(purchaseData);

      // 4. Mark listing as inactive in main collection
      await markAsSold(listingId, sellerId);

      // 5. Remove from all wishlists
      await removeFromAllWishlists(listingId);
    } catch (e) {
      throw 'Failed to complete sale: $e';
    }
  }

  // ── Delete ────────────────────────────────────────────────────────────────

  /// Deletes the listing document and all its images from Storage.
  /// Also removes from user's listedListings subcollection.
  Future<void> deleteListing(String listingId, String sellerId) async {
    try {
      await Future.wait([
        _firestore.collection(_collection).doc(listingId).delete(),
        _firestore
            .collection('users')
            .doc(sellerId)
            .collection('listedListings')
            .doc(listingId)
            .delete(),
        _storageService.deleteListingImages(listingId),
      ]);
    } catch (e) {
      throw 'Failed to delete listing: $e';
    }
  }
}
