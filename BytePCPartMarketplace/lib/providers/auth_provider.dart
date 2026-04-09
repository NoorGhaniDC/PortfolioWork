import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _authService.authStateChanges.listen((firebaseUser) async {
      if (firebaseUser != null) {
        _currentUser = await _authService.getUserProfile(firebaseUser.uid);
      } else {
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  Future<bool> register({
    required String email,
    required String password,
    required String username,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _currentUser = await _authService.register(
        email: email,
        password: password,
        username: username,
      );
      notifyListeners();
      return true;
    } catch (e) {
      // If it's a string (from AuthService error handler), use it directly
      if (e is String) {
        _errorMessage = e;
      } else {
        _errorMessage = e.toString();
      }
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _currentUser = await _authService.login(
        email: email,
        password: password,
      );
      notifyListeners();
      return true;
    } catch (e) {
      // If it's a string (from AuthService error handler), use it directly
      if (e is String) {
        _errorMessage = e;
      } else {
        _errorMessage = e.toString();
      }
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> isUsernameTaken(String username) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check username: $e');
    }
  }

  Future<void> updateProfile({
    String? username,
    String? bio,
  }) async {
    if (_currentUser == null) throw Exception('No user logged in');

    try {
      final updates = <String, dynamic>{};
      if (username != null) updates['username'] = username;
      if (bio != null) updates['bio'] = bio;

      await _firestore
          .collection('users')
          .doc(_currentUser!.userId)
          .update(updates);

      _currentUser = _currentUser!.copyWith(
        username: username ?? _currentUser!.username,
        bio: bio ?? _currentUser!.bio,
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      throw Exception('No user logged in');
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
