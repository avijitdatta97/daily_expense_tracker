import 'package:dio/dio.dart';
import 'api_exception.dart';
import 'auth_interceptor.dart';
import '../services/storage_service.dart';

class ApiClient {
  late final Dio _dio;
  final StorageService _storageService;

  // Base URL for Spring Boot backend
  // Use http://10.0.2.2:8080/api/v1/ for Android Emulator
  // Use http://localhost:8080/api/v1/ for iOS Simulator / Web
  // Use your local network IP (e.g., http://192.168.x.x:8080/api/v1/) for physical device
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1/';

  ApiClient(this._storageService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    _dio.interceptors.add(AuthInterceptor(_storageService));
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.post(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: 'DELETE'),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
