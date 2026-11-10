class TransactionModel {
  final int id;
  final String type; // 'INCOME' or 'EXPENSE'
  final double amount;
  final String account;
  final DateTime transactionDate;
  final String? note;
  final int categoryId;
  final String categoryName;
  final int subcategoryId;
  final String subcategoryName;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.account,
    required this.transactionDate,
    this.note,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
  });

  /// Compatibility getter for transactionName
  String get transactionName {
    if (subcategoryName.isNotEmpty) {
      return subcategoryName;
    }
    if (categoryName.isNotEmpty) {
      return categoryName;
    }
    return note ?? 'Transaction';
  }

  /// Compatibility getter for transactionAmount
  double get transactionAmount => amount;

  /// Compatibility getter for transactionType
  String get transactionType => type;

  /// Convert JSON → Model
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;
    try {
      if (json['transactionDate'] != null) {
        final dateStr = json['transactionDate'].toString();
        final timeStr =
            json['transactionTime'] != null ? json['transactionTime'].toString() : '00:00:00';
        parsedDate = DateTime.parse('${dateStr}T$timeStr');
      } else {
        parsedDate = DateTime.now();
      }
    } catch (_) {
      parsedDate = DateTime.now();
    }

    return TransactionModel(
      id: json['id'] is num ? (json['id'] as num).toInt() : 0,
      type: json['type'] ?? 'EXPENSE',
      amount: json['amount'] is num ? (json['amount'] as num).toDouble() : 0.0,
      account: json['account'] ?? '',
      transactionDate: parsedDate,
      note: json['note'],
      categoryId: json['categoryId'] is num ? (json['categoryId'] as num).toInt() : 0,
      categoryName: json['categoryName'] ?? '',
      subcategoryId: json['subcategoryId'] is num ? (json['subcategoryId'] as num).toInt() : 0,
      subcategoryName: json['subcategoryName'] ?? '',
    );
  }

  /// Convert Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'account': account,
      'transactionDate': transactionDate.toIso8601String().split('T')[0],
      'note': note,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'subcategoryId': subcategoryId,
      'subcategoryName': subcategoryName,
    };
  }
}
