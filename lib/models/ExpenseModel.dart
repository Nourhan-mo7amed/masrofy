class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? note; 

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.note, 
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "categoryId": categoryId,
        "date": date.toIso8601String(),
        "note": note,
      };

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json["id"],
        title: json["title"],
        amount: (json["amount"] as num).toDouble(),
        categoryId: json["categoryId"],
        date: DateTime.parse(json["date"]),
        note: json["note"],
      );
}
