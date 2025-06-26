import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/add_user_usecase.dart';
import '../../data/repositories/user_repository_impl.dart';

/// Provides the user repository implementation
final userRepositoryProvider = Provider<UserRepositoryImpl>(
  (ref) => UserRepositoryImpl(),
);

/// Provides the list of users as an AsyncValue (loading, data, error)
final usersProvider =
    StateNotifierProvider<UsersNotifier, AsyncValue<List<UserEntity>>>((ref) {
      final repo = ref.watch(userRepositoryProvider);
      return UsersNotifier(
        getUsersUseCase: GetUsersUseCase(repo),
        addUserUseCase: AddUserUseCase(repo),
      );
    });

/// StateNotifier to manage user fetching and adding logic
class UsersNotifier extends StateNotifier<AsyncValue<List<UserEntity>>> {
  final GetUsersUseCase getUsersUseCase;
  final AddUserUseCase addUserUseCase;

  UsersNotifier({required this.getUsersUseCase, required this.addUserUseCase})
    : super(const AsyncLoading()) {
    fetchUsers();
  }

  /// Fetch users from the repository and update state
  Future<void> fetchUsers() async {
    state = const AsyncLoading();
    try {
      final users = await getUsersUseCase();
      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Add a new user and refresh the user list
  Future<void> addUser(UserEntity user) async {
    try {
      await addUserUseCase(user);
      // Fetch users and ensure the newly added user appears at the top
      state = const AsyncLoading();
      final users = await getUsersUseCase();
      // Place the new user at the top
      final updatedUsers = [user, ...users.where((u) => u.email != user.email)];
      state = AsyncData(updatedUsers);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

/// Holds the currently selected user for detail view
final selectedUserProvider = StateProvider<UserEntity?>((ref) => null);

/// Holds the current search query for filtering users
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Provides a filtered list of users based on the search query
final filteredUsersProvider = Provider<AsyncValue<List<UserEntity>>>((ref) {
  final usersAsync = ref.watch(usersProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return usersAsync.when(
    data: (users) {
      if (query.isEmpty) {
        return AsyncValue.data(users);
      }
      // Filter users by name, email, or username (case-insensitive)
      final filtered = users.where((user) {
        return user.name.toLowerCase().contains(query) ||
            user.email.toLowerCase().contains(query) ||
            (user.username?.toLowerCase().contains(query) ?? false);
      }).toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});
