import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/workout.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get _userId => _auth.currentUser?.uid;

  // Add a new workout
  Future<void> addWorkout(Workout workout) async {
    if (_userId == null) throw Exception('User not authenticated');

    await _firestore.collection('workouts').add(workout.toMap());
  }

  // Get all workouts for current user as a stream
  Stream<List<Workout>> getUserWorkouts() {
    if (_userId == null) return Stream.value([]);

    return _firestore
        .collection('workouts')
        .where('userId', isEqualTo: _userId)
        .snapshots()
        .map((snapshot) {
      // Sort in memory instead of using Firestore ordering
      final workouts = snapshot.docs.map((doc) {
        return Workout.fromMap(doc.id, doc.data());
      }).toList();

      // Sort by date descending (newest first)
      workouts.sort((a, b) => b.date.compareTo(a.date));

      return workouts;
    });
  }

  // Delete a workout
  Future<void> deleteWorkout(String workoutId) async {
    await _firestore.collection('workouts').doc(workoutId).delete();
  }

  // Update a workout
  Future<void> updateWorkout(String workoutId, Workout workout) async {
    await _firestore.collection('workouts').doc(workoutId).update(workout.toMap());
  }
}