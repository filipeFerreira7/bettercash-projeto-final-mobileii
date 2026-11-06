import 'json.dart';
import 'user.dart';

/// Active authenticated user session token and user profile.
class Session {
  const Session({
    required this.token,
    required this.user,
  });

  factory Session.fromJson(Json json) {
    return Session(
      token: json['token'] as String? ?? '',
      user: User.fromJson(json['user'] as Json? ?? {}),
    );
  }

  final String token;
  final User user;

  Json toJson() => {
        'token': token,
        'user': user.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Session &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          user == other.user;

  @override
  int get hashCode => Object.hash(token, user);
}
