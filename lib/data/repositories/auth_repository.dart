import '../../core/network/api_client.dart';
import '../../models/AuthResponse.dart';
import '../../models/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<AuthResponse> login(String email, String password) async {
    final response = await _apiClient.post(
      'auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> signup({
    required String name,
    required String email,
    required String? phone,
    required String password,
  }) async {
    final response = await _apiClient.post(
      'auth/signup',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<void> logout(String refreshToken) async {
    await _apiClient.post(
      'auth/logout',
      data: {
        'refreshToken': refreshToken,
      },
    );
  }

  Future<void> forgotPassword(String email) async {
    await _apiClient.post(
      'auth/forgot-password',
      data: {
        'email': email,
      },
    );
  }

  Future<void> resetPassword(String token, String newPassword) async {
    await _apiClient.post(
      'auth/reset-password',
      data: {
        'token': token,
        'newPassword': newPassword,
      },
    );
  }
}
