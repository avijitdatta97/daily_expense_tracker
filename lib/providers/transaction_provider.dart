import 'package:flutter/material.dart';
import '../data/repositories/transaction_repository.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _transactionRepository;

  TransactionProvider(this._transactionRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> createTransaction({
    required String type,
    required double amount,
    required int categoryId,
    required int subcategoryId,
    required String account,
    required String transactionDate,
    required String transactionTime,
    String? note,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _transactionRepository.createTransaction(
        type: type,
        amount: amount,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        account: account,
        transactionDate: transactionDate,
        transactionTime: transactionTime,
        note: note,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
