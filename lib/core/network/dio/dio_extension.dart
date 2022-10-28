import 'dart:io';
import 'package:dio/dio.dart';
import 'package:task/core/network/utils/base_response.dart';

extension DioEx on Dio {
  /// Top level methods
  /// common GET method
  Future<ApiResponse> getApi(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Response response = await get(
        path,
        queryParameters: queryParameters,
      );
      return _getResponse(response);
    } on DioError catch (e) {
      throw _getError(e);
    }
  }

  /// Common POST method
  Future<ApiResponse> postApi(
    String path, {
    dynamic map,
  }) async {
    try {
      Response response = await post(
        path,
        data: map,
      );
      return _getResponse(response);
    } on DioError catch (e) {
      throw _getError(e);
    }
  }

  ApiResponse _getResponse(Response response) {
    return ApiResponse(response.data);
  }

  ApiError _getError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return ApiError(ErrorType.timeout);
      case DioErrorType.response: //401, 404, 403
        return ApiError(ErrorType.apiFailure,
            message: "Client request not been completed");
      case DioErrorType.other:
        if (e.error is HttpException) {
          return ApiError(ErrorType.noConnection);
        }
        return ApiError(ErrorType.unknown);
      default:
        return ApiError(ErrorType.unknown);
    }
  }
}
