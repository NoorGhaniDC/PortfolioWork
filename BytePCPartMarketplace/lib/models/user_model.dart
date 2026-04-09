class UserModel {
  final String userId;
  final String username;
  final String email;
  final DateTime createdAt;
  final String? bio;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.createdAt,
    this.bio,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? bio,
    bool clearBio = false,
  }) {
    return UserModel(
      userId: userId,
      username: username ?? this.username,
      email: email ?? this.email,
      createdAt: createdAt,
      bio: clearBio ? null : (bio ?? this.bio),
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      bio: map['bio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'bio': bio,
    };
  }
}