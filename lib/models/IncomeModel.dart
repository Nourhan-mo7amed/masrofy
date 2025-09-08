class IncomeModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String source;

  IncomeModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.source,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "date": date.toIso8601String(),
        "source": source,
      };

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
        id: json["id"],
        title: json["title"],
        amount: (json["amount"] as num).toDouble(),
        date: DateTime.parse(json["date"]),
        source: json["source"],
      );
}
