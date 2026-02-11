class TransactionModel {
  final String transactionId;
  final String transactionName;
  final double transactionAmount;
  final DateTime transactionDate;
  final String transactionType;

  TransactionModel({
    required this.transactionId,
    required this.transactionName,
    required this.transactionAmount,
    required this.transactionDate,
    required this.transactionType
  });

  /// Convert JSON → Model
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transactionId'],
      transactionName: json['transactionName'],
      transactionAmount: (json['transactionAmount'] as num).toDouble(),
      transactionDate: DateTime.parse(json['transactionDate']),
      transactionType: json['transactionType']
    );
  }

  /// Convert Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'transactionName': transactionName,
      'transactionAmount': transactionAmount,
      'transactionDate': transactionDate.toIso8601String(),
      'transactionType': transactionType
    };
  }
}
