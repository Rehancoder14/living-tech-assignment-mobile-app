import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

enum ApiMessage {
  success,
  internalServerError,
  somethingWantWrongError,
  apiError,
  permissionError,
}

extension ApiMessageExtension on ApiMessage {
  String get asString {
    switch (this) {
      case ApiMessage.apiError:
        return 'Api Error';
      case ApiMessage.internalServerError:
        return 'Internal Server Error';
      case ApiMessage.somethingWantWrongError:
        return 'Something Want Wrong';
      case ApiMessage.success:
        return 'Success';
      case ApiMessage.permissionError:
        return 'Permission Denied';
      default:
        return 'Something Want Wrong';
    }
  }
}

class ApiResponse {
  dynamic data;
  int? dataCount;
  ApiMessage? message;

  ApiResponse({this.data, this.message, this.dataCount});
}

class ApiCallWithErrorHandler {
  ApiCallWithErrorHandler._();

  static Future<Either<ApiError, T>> call<T>(Future<T> Function() f) async {
    try {
      return Right(await f());
    } on SocketException catch (e) {
      return Left(ApiError(
        message: ApiMessage.apiError,
        error: e.toString(),
      ));
    } on TimeoutException catch (e) {
      return Left(ApiError(
        message: ApiMessage.apiError,
        error: e.toString(),
      ));
    } on DioException catch (e) {
      return Left(
        ApiError(
          message: ApiMessage.apiError,
          error:
              'Api Error: ${e.response?.statusCode} ${e.response?.statusMessage} ${e.response?.data}',
        ),
      );
    } catch (e) {
      return Left(
        ApiError(
          message: ApiMessage.somethingWantWrongError,
          error: e.toString(),
        ),
      );
    }
  }
}

class ApiError {
  ApiMessage? message;
  String? error;

  ApiError({
    this.message,
    this.error,
  });
}
