import 'json.dart';

/// User profile domain model.
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    this.avatarUrl,
  });

  factory User.fromJson(Json json) {
    return User(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime createdAt;

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? Function()? avatarUrl,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl != null ? avatarUrl() : this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Json toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
        'createdAt': createdAt.toUtc().toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          avatarUrl == other.avatarUrl &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, name, email, avatarUrl, createdAt);

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
