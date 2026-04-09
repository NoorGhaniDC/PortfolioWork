import 'package:flutter/foundation.dart';
import '../models/listing_model.dart';
import '../services/listing_service.dart';

class ListingProvider extends ChangeNotifier {
  final ListingService _listingService = ListingService();

  List<ListingModel> _listings = [];
  ListingModel? _selectedListing;
  bool _isLoading = false;
  String? _errorMessage;

  // Filters
  String _selectedCategory = 'All';
  String _selectedCondition = 'All';
  double? _maxPrice;
  String _searchQuery = '';

  // Getters
  List<ListingModel> get listings => _listings;
  ListingModel? get selectedListing => _selectedListing;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get selectedCondition => _selectedCondition;
  double? get maxPrice => _maxPrice;
  String get searchQuery => _searchQuery;

  Future<void> fetchListings() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _listings = await _listingService.getListings(
        category: _selectedCategory,
        condition: _selectedCondition,
        maxPrice: _maxPrice,
        searchQuery: _searchQuery,
      );
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchListingById(String listingId) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _selectedListing = await _listingService.getListingById(listingId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// Creates a listing and uploads [imageBytesList] to Firebase Storage.
  Future<bool> createListing(
    ListingModel listing,
    List<Uint8List> imageBytesList,
  ) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      final created = await _listingService.createListing(
        listing,
        imageBytesList,
      );
      _listings.insert(0, created);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Updates a listing, optionally adding new images or removing existing ones.
  Future<bool> updateListing(
    ListingModel listing, {
    List<Uint8List>? newImageBytesList,
    List<String>? removedImageUrls,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      final updated = await _listingService.updateListing(
        listing,
        newImageBytesList: newImageBytesList,
        removedImageUrls: removedImageUrls,
      );
      // Replace in local list
      final index =
          _listings.indexWhere((l) => l.listingId == listing.listingId);
      if (index != -1) _listings[index] = updated;
      if (_selectedListing?.listingId == listing.listingId) {
        _selectedListing = updated;
      }
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteListing(String listingId, String sellerId) async {
    _errorMessage = null;
    try {
      await _listingService.deleteListing(listingId, sellerId);
      _listings.removeWhere((l) => l.listingId == listingId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> markAsSold(String listingId, String sellerId) async {
    _errorMessage = null;
    try {
      await _listingService.markAsSold(listingId, sellerId);
      _listings.removeWhere((l) => l.listingId == listingId);
      if (_selectedListing?.listingId == listingId) {
        _selectedListing = _selectedListing!.copyWith(isActive: false);
      }
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Completes a sale: moves listing from listedListings to soldListings,
  /// adds to buyer's purchasedListings, and removes from all wishlists
  Future<bool> completeSale(
    String listingId,
    String sellerId,
    String buyerId,
    ListingModel listing,
  ) async {
    _errorMessage = null;
    try {
      await _listingService.completeSale(
        listingId,
        sellerId,
        buyerId,
        listing,
      );
      _listings.removeWhere((l) => l.listingId == listingId);
      if (_selectedListing?.listingId == listingId) {
        _selectedListing = _selectedListing!.copyWith(isActive: false);
      }
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    fetchListings();
  }

  void setCondition(String condition) {
    _selectedCondition = condition;
    fetchListings();
  }

  void setMaxPrice(double? price) {
    _maxPrice = price;
    fetchListings();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    fetchListings();
  }

  void clearFilters() {
    _selectedCategory = 'All';
    _selectedCondition = 'All';
    _maxPrice = null;
    _searchQuery = '';
    fetchListings();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
