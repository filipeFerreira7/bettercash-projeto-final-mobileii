import '../../api/api_client.dart';
import '../../models/json.dart';
import '../../models/user.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../user_repository.dart';

class RemoteUserRepository implements UserRepository {
  RemoteUserRepository({required ApiClient client}) : _client = client;

  final ApiClient _client;

  @override
  Future<Result<User>> getProfile() async {
    final res = await _client.get('/me');
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid user profile response'));
      return Ok(User.fromJson(Map<String, Object?>.from(data)));
    });
  }

  @override
  Future<Result<User>> updateProfile({
    required String name,
    String? avatarUrl,
  }) async {
    final res = await _client.put(
      '/me',
      body: {
        'name': name,
        'avatarUrl': avatarUrl,
      },
    );
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid update profile response'));
      return Ok(User.fromJson(Map<String, Object?>.from(data)));
    });
  }
}
