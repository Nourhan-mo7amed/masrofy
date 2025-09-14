import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String userId;
  final String title;
  final double amount;
  final DateTime date;
  final String? notes;
  final String type; // expense or income
  final String? categoryId;
  final String? source;

  TransactionModel({
    required this.userId,
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
        "userId": userId,
        "title": title,
        "amount": amount,
        "categoryId": categoryId,
        "date": date, // 🟢 سيبها DateTime، Firestore هيخزنها Timestamp
        "notes": notes,
        "type": type,
        "source": source,
      };

  /// 🟢 تحويل من Map
  factory TransactionModel.fromJson(Map<String, dynamic> json, String id) {
    final dateData = json["date"];
    DateTime parsedDate;

    if (dateData is Timestamp) {
      parsedDate = dateData.toDate();
    } else if (dateData is String) {
      parsedDate = DateTime.tryParse(dateData) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return TransactionModel(
      id: id,
      userId: json["userId"] ?? "",
      title: json["title"] ?? "",
      amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
      date: parsedDate,
      notes: json["notes"],
      type: json["type"] ?? "expense",
      categoryId: json["categoryId"],
      source: json["source"],
    );
  }

  /// 🟢 طريقة مباشرة للـ Firestore
  factory TransactionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return TransactionModel.fromJson(data, doc.id);
  }
}
