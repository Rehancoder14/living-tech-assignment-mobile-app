import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:livingtechassignment/constants/api_constant.dart';
import 'package:livingtechassignment/helper/apibasehelper.dart';
import 'package:livingtechassignment/services/api_service.dart';
import 'package:livingtechassignment/services/local_storage_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  static final instance = AuthRepository._();
  AuthRepository._();

  Future<Either<ApiError, void>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return ApiCallWithErrorHandler.call(
      () async {
        log('registering user');
        final response = await _apiService.post(
          ApiConstant.baseUrl + ApiConstant.register,
          {
            "username": name,
            "password": password,
            "email": email,
          },
          isCustomBaseURL: true,
        );
        log(
          response.data.toString(),
        );
        return response.data;
      },
    );
  }

  Future<Either<ApiError, void>> login({
    required String email,
    required String password,
  }) async {
    return ApiCallWithErrorHandler.call(
      () async {
        final response = await _apiService.post(
          ApiConstant.baseUrl + ApiConstant.login,
          {
            "password": password,
            "email": email,
          },
        );
        LocalStorageService.updateUserData(response.data['data']);
        return response.data;
      },
    );
  }
}
