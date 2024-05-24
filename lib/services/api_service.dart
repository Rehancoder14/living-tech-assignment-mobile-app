import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:livingtechassignment/constants/api_constant.dart';

class ApiService extends ChangeNotifier {
  final _dio = Dio();
  final _baseUrl = ApiConstant.baseUrl;

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Content-Type'] = 'application/json';

          // String? token;

          // if (options.path == ApiConstant.dashboardUrl) {
          //   token = LocalStorageService.getUserValue(UserField.token);
          // }

          // if (token!.isNotEmpty) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }

          log(
            'Request: ${options.method} ${options.path} ${options.headers['Authorization']}',
          );
          log('${options.baseUrl}${options.path}');
          if (options.method != 'GET') {
            log(' - With -');
            log('${options.data}');
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('Response: ${response.statusCode} ${response.statusMessage}');

          return handler.next(response);
        },
        onError: (error, handler) {
          log('Error: ${error.response}');
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool? customBaseURL,
    bool? cache,
    Duration? cacheExpiry,
    CancelToken? cancelToken,
  }) async {
    _dio.options.baseUrl = customBaseURL ?? false ? path : _baseUrl;

    return await _dio.get(
      customBaseURL ?? false ? '' : path,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    // return _dio.get(path);
  }

  Future<Response> post(String path, dynamic data,
      {bool? isCustomBaseURL,
      bool? isUrlEncoded,
      String contentType = 'application/json'}) async {
    // await removeIfDataInCache(path);

    _dio.options.baseUrl = isCustomBaseURL ?? false ? path : _baseUrl;
    return await _dio.post(
      isCustomBaseURL ?? false ? '' : path,
      data: data,
      options: Options(contentType: contentType),
    );
  }
}
