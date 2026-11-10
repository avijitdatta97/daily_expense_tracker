import '../../core/network/api_client.dart';

class TransactionRepository {
  final ApiClient _apiClient;

  TransactionRepository(this._apiClient);

  Future<void> createTransaction({
    required String type,
    required double amount,
    required int categoryId,
    required int subcategoryId,
    required String account,
    required String transactionDate,
    required String transactionTime,
    String? note,
  }) async {
    await _apiClient.post(
      'transactions',
      data: {
        'type': type,
        'amount': amount,
        'categoryId': categoryId,
        'subcategoryId': subcategoryId,
        'account': account,
        'transactionDate': transactionDate,
        'transactionTime': transactionTime,
        'note': note,
      },
    );
  }
}
