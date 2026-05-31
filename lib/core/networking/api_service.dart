// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:dio/dio.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';

class ApiServices {
  final Dio _dio;
  ApiServices(this._dio);

  /// GET
  Future getData({required String url, Map<String, String>? headers}) async {
    try {
      final finalHeaders = {...?headers};
      final response = await _dio.get(
        url,
        options: Options(headers: finalHeaders),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  /// POST
  Future postData({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final finalHeaders = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        ...?headers,
      };

      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: finalHeaders),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  Future postFormData({
    required String url,
    required FormData data,
    Map<String, String>? headers,
  }) async {
    try {
      final finalHeaders = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        ...?headers,
      };

      final response = await _dio.post(
        url,
        data: data,
        options: Options(headers: finalHeaders),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  /// PUT
  Future putData({
    required String url,
    required dynamic body,
    Map<String, String>? headers,
  }) async {
    try {
      final finalHeaders = {...?headers};

      final response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: finalHeaders),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }

  /// DELETE
  Future deleteData({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final finalHeaders = {...?headers};

      final response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: finalHeaders),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    }
  }
}

dynamic _handleResponse(Response response) {
  if ([200, 201, 204].contains(response.statusCode)) {
    return response.data;
  } else {
    throw ServerFailure.fromResponse(response.statusCode, response.data);
  }
}
