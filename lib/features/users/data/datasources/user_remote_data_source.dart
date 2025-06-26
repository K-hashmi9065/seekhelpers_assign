import 'package:dio/dio.dart';
import 'dart:io';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failures.dart';
import '../models/user_model.dart';

/// Abstract class for remote data source to fetch users from API
abstract class UserRemoteDataSource {
  /// Fetches a list of users from the remote API
  Future<List<UserModel>> getUsers();
}

/// Implementation of [UserRemoteDataSource] using Dio for HTTP requests
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  /// Constructor allows injecting a custom Dio instance (useful for testing)
  UserRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? Dio();

  /// Fetches users from the API endpoint
  /// Throws [ServerFailure] for server errors and [NetworkFailure] for network issues
  @override
  Future<List<UserModel>> getUsers() async {
    try {
      // Make GET request to fetch users
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.usersEndpoint}',
      );
      if (response.statusCode == 200) {
        // Parse response data into a list of UserModel
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => UserModel.fromJson(json)).toList();
      } else {
        // Throw server failure if status code is not 200
        throw ServerFailure(message: 'Failed to fetch users');
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions, especially for network issues
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.error is SocketException) {
        throw NetworkFailure(message: 'No internet connection');
      } else {
        throw NetworkFailure(message: 'Network error occurred');
      }
    } catch (e) {
      // Handle any other unexpected errors
      throw NetworkFailure(message: 'Unexpected error occurred');
    }
  }
}
