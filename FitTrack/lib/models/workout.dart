class Workout {
  final String id;
  final String userId;
  final String exercise;
  final String workoutType; // 'weight' or 'distance'

  // Weight-based fields
  final int? sets;
  final int? reps;
  final double? weight;
  final String? weightUnit;

  // Distance-based fields
  final double? distance;
  final int? duration; // in seconds
  final String? distanceUnit;

  final DateTime date;
  final String? notes;

  Workout({
    required this.id,
    required this.userId,
    required this.exercise,
    required this.workoutType,
    this.sets,
    this.reps,
    this.weight,
    this.weightUnit,
    this.distance,
    this.duration,
    this.distanceUnit,
    required this.date,
    this.notes,
  });

  // Convert Workout to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'exercise': exercise,
      'workoutType': workoutType,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'weightUnit': weightUnit,
      'distance': distance,
      'duration': duration,
      'distanceUnit': distanceUnit,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  // Create Workout from Firestore document
  factory Workout.fromMap(String id, Map<String, dynamic> map) {
    return Workout(
      id: id,
      userId: map['userId'] ?? '',
      exercise: map['exercise'] ?? '',
      workoutType: map['workoutType'] ?? 'weight',
      sets: map['sets'],
      reps: map['reps'],
      weight: map['weight']?.toDouble(),
      weightUnit: map['weightUnit'],
      distance: map['distance']?.toDouble(),
      duration: map['duration'],
      distanceUnit: map['distanceUnit'],
      date: DateTime.parse(map['date']),
      notes: map['notes'],
    );
  }
}