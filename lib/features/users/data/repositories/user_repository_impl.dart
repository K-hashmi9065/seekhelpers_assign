import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../datasources/user_local_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    UserRemoteDataSource? remoteDataSource,
    UserLocalDataSource? localDataSource,
  }) : remoteDataSource = remoteDataSource ?? UserRemoteDataSourceImpl(),
       localDataSource = localDataSource ?? UserLocalDataSourceImpl();

  @override
  Future<List<UserEntity>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      return users.map((m) => m.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addUser(UserEntity user) async {
    try {
      await localDataSource.addLocalUser(UserModel.fromEntity(user));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    try {
      final apiUsers = await getUsers();
      final localUsers = await localDataSource.getLocalUsers();

      final localEntities = localUsers
          .map((m) => m.toEntity())
          .whereType<UserEntity>()
          .toList();

      return [...apiUsers, ...localEntities];
    } catch (e) {
      rethrow;
    }
  }
}
