import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/servicse.dart';

class DioFactory {
  DioFactory._();
  static Dio? dio;
  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final service = SharedPreferencesService();
          final token = await service.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
    dio?.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }
}

//    Dio(
//           BaseOptions(
//             baseUrl: ApiConstants.apiBaseUrl,
//             connectTimeout: const Duration(seconds: 30),
//             receiveTimeout: const Duration(seconds: 30),
//             sendTimeout: const Duration(seconds: 30),
//             headers: {
//               'Accept': 'application/json',
//               'Content-Type': 'application/json',
//             },
//           ),
//         )
//         ..interceptors.add(
//           InterceptorsWrapper(
//             onRequest: (options, handler) async {
//               print(
//                 "[${options.method}][${options.uri}] headers: ${options.headers}",
//               );

//               final service = SharedPreferencesService();

//               final token = await service.getAccessToken();

//               if (token != null && token.isNotEmpty) {
//                 options.headers['Authorization'] = 'Bearer $token';
//               }
//               handler.next(options);
//             },
//             onResponse: (response, handler) {
//               // print("${response.data}");
//               handler.next(response);
//             },
//             onError: (error, handler) {
//               print("DIO ERROR: ${error.response?.data}");
//               print("STATUS CODE: ${error.response?.statusCode}");
//               handler.next(error);
//             },
//           ),
//         );
// }
