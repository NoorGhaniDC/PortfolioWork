class UserProfile {
  final String userId;
  final String name;
  final String email;
  final double weight;
  final double height;
  final String gender;
  final String weightUnit;
  final String distanceUnit;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.userId,
    required this.name,
    required this.email,
    required this.weight,
    required this.height,
    required this.gender,
    required this.weightUnit,
    required this.distanceUnit,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'weight': weight,
      'height': height,
      'gender': gender,
      'weightUnit': weightUnit,
      'distanceUnit': distanceUnit,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      weight: (map['weight'] ?? 70.0).toDouble(),
      height: (map['height'] ?? 170.0).toDouble(),
      gender: map['gender'] ?? 'Male',
      weightUnit: map['weightUnit'] ?? 'kg',
      distanceUnit: map['distanceUnit'] ?? 'km',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
    );
  }

  UserProfile copyWith({
    String? userId,
    String? name,
    String? email,
    double? weight,
    double? height,
    String? gender,
    String? weightUnit,
    String? distanceUnit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}