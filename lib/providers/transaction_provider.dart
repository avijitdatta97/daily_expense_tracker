import 'package:flutter/material.dart';
import '../data/repositories/transaction_repository.dart';
import '../models/TransactionModel.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _transactionRepository;

  TransactionProvider(this._transactionRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isFetchingTransactions = false;
  bool get isFetchingTransactions => _isFetchingTransactions;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  Future<void> fetchTransactions({int? month, int? year}) async {
    final now = DateTime.now();
    final targetMonth = month ?? now.month;
    final targetYear = year ?? now.year;

    _isFetchingTransactions = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _transactions = await _transactionRepository.getTransactions(
        month: targetMonth,
        year: targetYear,
      );
      _isFetchingTransactions = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isFetchingTransactions = false;
      notifyListeners();
    }
  }

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
      await fetchTransactions();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTransaction(int id) async {
    try {
      await _transactionRepository.deleteTransaction(id);
      _transactions.removeWhere((t) => t.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
