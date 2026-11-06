import '../models/user.dart';
import '../result/result.dart';

abstract interface class UserRepository {
  Future<Result<User>> getProfile();
  Future<Result<User>> updateProfile({
    required String name,
    String? avatarUrl,
  });
}
