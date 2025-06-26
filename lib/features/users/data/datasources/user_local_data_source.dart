import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failures.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getLocalUsers();
  Future<void> addLocalUser(UserModel user);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String _localUsersKey = 'local_users';

  @override
  Future<List<UserModel>> getLocalUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? usersJson = prefs.getString(_localUsersKey);
      if (usersJson != null) {
        final List<dynamic> jsonList = json.decode(usersJson);
        return jsonList.map((json) => UserModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addLocalUser(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<UserModel> existingUsers = await getLocalUsers();
      final localUser = UserModel(
        id: -(existingUsers.length + 1),
        name: user.name,
        email: user.email,
        phone: user.phone,
        username: user.username,
        website: user.website,
        address: user.address as AddressModel?,
        company: user.company as CompanyModel?,
      );
      existingUsers.add(localUser);
      final List<Map<String, dynamic>> jsonList = existingUsers
          .map((user) => user.toJson())
          .toList();
      await prefs.setString(_localUsersKey, json.encode(jsonList));
    } catch (e) {
      throw CacheFailure(message: 'Failed to save user locally');
    }
  }
}
