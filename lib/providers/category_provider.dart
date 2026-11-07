import 'package:flutter/material.dart';
import '../data/repositories/category_repository.dart';
import '../models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository _categoryRepository;

  CategoryProvider(this._categoryRepository);

  List<CategoryModel> _incomeCategories = [];
  List<CategoryModel> get incomeCategories => _incomeCategories;

  List<CategoryModel> _expenseCategories = [];
  List<CategoryModel> get expenseCategories => _expenseCategories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isFetched = false;
  bool get isFetched => _isFetched;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CategoryModel> getCategoriesByType(String type) {
    if (type.toUpperCase() == 'INCOME') {
      return _incomeCategories;
    } else {
      return _expenseCategories;
    }
  }

  Future<void> fetchAllCategories({bool forceRefresh = false}) async {
    if (_isFetched && !forceRefresh) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _categoryRepository.getCategories('INCOME'),
        _categoryRepository.getCategories('EXPENSE'),
      ]);

      _incomeCategories = results[0];
      _expenseCategories = results[1];
      _isFetched = true;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
