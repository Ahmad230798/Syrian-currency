// ignore_for_file: unreachable_switch_default
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:syrian_currency/core/errors/api_error_model.dart';

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure("Connection to the server timed out");
      case DioExceptionType.sendTimeout:
        return const ServerFailure("Request sending timed out");
      case DioExceptionType.receiveTimeout:
        return const ServerFailure("Response receiving timed out");
      case DioExceptionType.badCertificate:
        return const ServerFailure("Invalid server certificate");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return const ServerFailure("Request was cancelled");
      case DioExceptionType.connectionError:
        return const ServerFailure("No internet connection");
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          return const ServerFailure("No internet connection");
        }
        return const ServerFailure(
          "Unexpected error occurred. Please try again",
        );
      default:
        return const ServerFailure(
          "Unexpected error occurred. Please try again",
        );
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic responseData) {
    String? extractedMessage;
    if (responseData is Map<String, dynamic>) {
      try {
        final errorModel = ApiErrorModel.fromJson(responseData);
        extractedMessage = errorModel.primaryErrorMessage;
      } catch (e) {
        extractedMessage = null;
      }
    } else if (responseData is String && responseData.isNotEmpty) {
      extractedMessage = responseData;
    }

    switch (statusCode) {
      case 400:
        return ServerFailure(
          extractedMessage ?? "Invalid request. Please check your input",
        );
      case 401:
        return const ServerFailure("Unauthorized. Please log in again");
      case 403:
        return const ServerFailure("Access denied");
      case 404:
        return const ServerFailure("Resource not found");
      case 422:
        return ServerFailure(extractedMessage ?? "Validation error occurred");
      case 429:
        return const ServerFailure("Too many requests. Please try again later");
      case 500:
        return const ServerFailure(
          "Internal server error. Please try again later",
        );
      case 502:
        return const ServerFailure("Bad gateway");
      case 503:
        return const ServerFailure(
          "Service unavailable. Please try again later",
        );
      case 504:
        return const ServerFailure("Gateway timeout");
      default:
        return ServerFailure(extractedMessage ?? "Something went wrong");
    }
  }
}
//   static String? _extractErrorMessage(dynamic data) {
//     if (data == null) return null;
//     if (data is String && data.isNotEmpty) {
//       return data;
//     }
//     if (data is Map<String, dynamic>) {
//       String messages;
//       // if (data['message'] is String && data['message'].toString().isNotEmpty) {
//       //   messages.add(data['message']);
//       // }
//       if (data['error'] is String && data['error'].toString().isNotEmpty) {
//         messages = data['error'];
//         return messages;
//       }
//       for (final entry in data.entries) {
//         final value = entry.value;

//         if (value is List) {
//           for (final item in value) {
//             if (item is String && item.isNotEmpty) {
//               messages = item;
//               return messages;
//             }
//           }
//         } else if (value is String && value.isNotEmpty) {
//           messages = value;
//           return messages;
//         }
//       }
//     }
//     return null;
//   }
// }
