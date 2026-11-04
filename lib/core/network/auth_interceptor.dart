import 'package:dio/dio.dart';
import '../services/storage_service.dart';

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;

  AuthInterceptor(this._storageService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final isPublicEndpoint = options.path.contains('auth/login') ||
        options.path.contains('auth/signup') ||
        options.path.contains('auth/forgot-password') ||
        options.path.contains('auth/reset-password');

    if (!isPublicEndpoint) {
      final token = await _storageService.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Clear tokens on unauthorized response
      _storageService.clearTokens();
    }
    super.onError(err, handler);
  }
}
