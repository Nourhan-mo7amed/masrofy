import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String? notes;
  final String type;
  final String? categoryId;
  final String? source;

  TransactionModel({
    required this.id,
    this.categoryId,
    this.source,
    required this.title,
    required this.amount,
    required this.date,
    this.notes,
    required this.type,
  });
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "amount": amount,
    "categoryId": categoryId,
    "date": date.toIso8601String(),
    "notes": notes,
    "type": type,
    "source": source,
  };
  factory TransactionModel.fromJson(Map<String, dynamic> json, String id) =>
      TransactionModel(
        id: id,
        title: json["title"] ?? "",
        amount: (json["amount"] as num).toDouble(),
        date: DateTime.parse(json["date"]),
        notes: json["notes"],
        type: json["type"],
        categoryId: json["categoryId"],
        source: json["source"],
      );

  /// 🟢 طريقة مباشرة للـ Firestore DocumentSnapshot
  factory TransactionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return TransactionModel.fromJson(data, doc.id);
  }
}
