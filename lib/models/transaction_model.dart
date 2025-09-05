class TransactionModel {
  final String title;
  final double amount;
  final DateTime date;
  final String? notes;
  final String type;
  final int? categoryIndex;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    this.notes,
    required this.type,
    this.categoryIndex,
  });
}
