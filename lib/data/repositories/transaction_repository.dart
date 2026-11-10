import '../../core/network/api_client.dart';
import '../../models/TransactionModel.dart';

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

  Future<List<TransactionModel>> getTransactions({
    required int month,
    required int year,
  }) async {
    final response = await _apiClient.get(
      'transactions',
      queryParameters: {
        'month': month,
        'year': year,
      },
    );

    if (response.data is List) {
      return (response.data as List)
          .map((item) => TransactionModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<void> deleteTransaction(int id) async {
    await _apiClient.delete('transactions/$id');
  }
}
