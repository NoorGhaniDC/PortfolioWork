import 'package:flutter/material.dart';
import '../models/parts_catalog_model.dart';
import '../services/parts_catalog_service.dart';

class PartsCatalogProvider extends ChangeNotifier {
  final PartsCatalogService _service = PartsCatalogService();

  // Step 1 — Category
  String? _selectedCategory;

  // Step 2 — Manufacturer
  List<String> _manufacturers = [];
  String? _selectedManufacturer;
  bool _isLoadingManufacturers = false;

  // Step 3 — Model
  List<PartsCatalogModel> _models = [];
  PartsCatalogModel? _selectedPart;
  bool _isLoadingModels = false;

  String? _errorMessage;

  // --- Getters ---
  String? get selectedCategory => _selectedCategory;
  List<String> get manufacturers => _manufacturers;
  String? get selectedManufacturer => _selectedManufacturer;
  bool get isLoadingManufacturers => _isLoadingManufacturers;
  List<PartsCatalogModel> get models => _models;
  PartsCatalogModel? get selectedPart => _selectedPart;
  bool get isLoadingModels => _isLoadingModels;
  String? get errorMessage => _errorMessage;

  /// True only when all three steps are complete
  bool get isPartSelected => _selectedPart != null;

  // --- Step 1: Select category ---
  Future<void> selectCategory(String category) async {
    // Reset downstream selections
    _selectedCategory = category;
    _selectedManufacturer = null;
    _selectedPart = null;
    _models = [];
    _manufacturers = [];
    _errorMessage = null;

    _isLoadingManufacturers = true;
    notifyListeners();

    try {
      _manufacturers = await _service.getManufacturers(category);
    } catch (e) {
      _errorMessage = 'Failed to load manufacturers: $e';
    } finally {
      _isLoadingManufacturers = false;
      notifyListeners();
    }
  }

  // --- Step 2: Select manufacturer ---
  Future<void> selectManufacturer(String manufacturer) async {
    // Reset downstream
    _selectedManufacturer = manufacturer;
    _selectedPart = null;
    _models = [];
    _errorMessage = null;

    _isLoadingModels = true;
    notifyListeners();

    try {
      _models = await _service.getModels(_selectedCategory!, manufacturer);
    } catch (e) {
      _errorMessage = 'Failed to load models: $e';
    } finally {
      _isLoadingModels = false;
      notifyListeners();
    }
  }

  // --- Step 3: Select model ---
  void selectModel(PartsCatalogModel part) {
    _selectedPart = part;
    notifyListeners();
  }

  /// Reset everything (e.g. when leaving the screen)
  void reset() {
    _selectedCategory = null;
    _selectedManufacturer = null;
    _selectedPart = null;
    _manufacturers = [];
    _models = [];
    _errorMessage = null;
    _isLoadingManufacturers = false;
    _isLoadingModels = false;
    notifyListeners();
  }
}