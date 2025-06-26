import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<void> addUser(UserEntity user);
  Future<List<UserEntity>> getAllUsers();
}