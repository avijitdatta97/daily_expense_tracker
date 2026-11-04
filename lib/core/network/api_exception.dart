import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: 'Connection timeout with API server');
      case DioExceptionType.badResponse:
        final data = dioException.response?.data;
        String errorMessage = 'Received invalid status code: ${dioException.response?.statusCode}';
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          errorMessage = data['message'];
        } else if (data is String && data.isNotEmpty) {
          errorMessage = data;
        }
        return ApiException(
          message: errorMessage,
          statusCode: dioException.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiException(message: 'Request to API server was cancelled');
      case DioExceptionType.connectionError:
        return ApiException(message: 'No internet connection');
      default:
        return ApiException(message: 'An unexpected error occurred');
    }
  }

  @override
  String toString() => message;
}
