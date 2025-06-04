import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interceptors.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 300;
    if (!isValid) {
      throw DioException.badResponse(
        statusCode: status!,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    super.onResponse(response, handler);
  }
}

class DioClient {
  late final Dio _dio;

  static String baseURL = dotenv.env["MCDA_API_SERVER"] ?? '';

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseURL,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          responseType: ResponseType.json,
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      )..interceptors.addAll([LoggerInterceptor(), ErrorInterceptor()]);

  // Helper to get token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final token = await _getToken();
    final mergedOptions =
        options?.copyWith(
          headers: {
            ...?options.headers,
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ) ??
        Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        );
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final token = await _getToken();
    final mergedOptions =
        options?.copyWith(
          headers: {
            ...?options.headers,
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ) ??
        Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        );
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: mergedOptions,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final token = await _getToken();
    final mergedOptions =
        options?.copyWith(
          headers: {
            ...?options.headers,
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ) ??
        Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        );
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final token = await _getToken();
    final mergedOptions =
        options?.copyWith(
          headers: {
            ...?options.headers,
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ) ??
        Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        );
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
