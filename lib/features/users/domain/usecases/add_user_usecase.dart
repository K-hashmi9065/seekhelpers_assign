import '../repositories/user_repository.dart';
import '../entities/user_entity.dart';

class AddUserUseCase {
  final UserRepository repository;
  AddUserUseCase(this.repository);

  Future<void> call(UserEntity user) async => await repository.addUser(user);
}