import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String source;
  final String userId;   // 👈 نضيف userId
  final String? note;

  IncomeModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.source,
    required this.userId, // 👈 لازم يتبعت
    this.note,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "date": date.toIso8601String(),
        "source": source,
        "userId": userId, // 👈 نخزنه في الداتا
        "note": note,
      };

  factory IncomeModel.fromJson(Map<String, dynamic> json, String id) =>
      IncomeModel(
        id: id,
        title: json["title"] ?? "",
        amount: (json["amount"] as num).toDouble(),
        date: DateTime.parse(json["date"]),
        source: json["source"] ?? "",
        userId: json["userId"], // 👈 نستقبله هنا
        note: json["note"],
      );

  /// 🟢 طريقة مباشرة للـ Firestore DocumentSnapshot
  factory IncomeModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return IncomeModel.fromJson(data, doc.id);
  }
}
