import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Create user profile
  Future<void> createUserProfile(UserProfile profile) async {
    await _firestore
        .collection('users')
        .doc(profile.userId)
        .set(profile.toMap());
  }

  // Get user profile
  Future<UserProfile?> getUserProfile() async {
    if (_userId == null) return null;

    final doc = await _firestore.collection('users').doc(_userId).get();

    if (!doc.exists) return null;

    return UserProfile.fromMap(doc.data()!);
  }

  // Get user profile as stream
  Stream<UserProfile?> getUserProfileStream() {
    if (_userId == null) return Stream.value(null);

    return _firestore
        .collection('users')
        .doc(_userId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return UserProfile.fromMap(doc.data()!);
    });
  }

  // Update user profile
  Future<void> updateUserProfile(UserProfile profile) async {
    if (_userId == null) throw Exception('User not authenticated');

    await _firestore
        .collection('users')
        .doc(_userId)
        .update(profile.copyWith(updatedAt: DateTime.now()).toMap());
  }

  // Update specific fields
  Future<void> updateUserFields(Map<String, dynamic> fields) async {
    if (_userId == null) throw Exception('User not authenticated');

    fields['updatedAt'] = DateTime.now().toIso8601String();

    await _firestore
        .collection('users')
        .doc(_userId)
        .update(fields);
  }

  // Check if user profile exists
  Future<bool> userProfileExists() async {
    if (_userId == null) return false;

    final doc = await _firestore.collection('users').doc(_userId).get();
    return doc.exists;
  }
}