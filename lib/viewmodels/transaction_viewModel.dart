import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/models/transaction_model.dart';

class TransactionViewmodel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ إضافة معاملة جديدة
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      final collectionName = transaction.type == "expense"
          ? "expenses"
          : "incomes";

      final docRef = _firestore.collection(collectionName).doc();

      await docRef.set({
        ...transaction.toJson(),
        "id": docRef.id,
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });

      notifyListeners();
    } catch (e) {
      throw Exception("Failed to save transaction: $e");
    }
  }

  /// ✅ Stream للمصاريف
  Stream<List<TransactionModel>> get expensesStream {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection("expenses")
        .where("userId", isEqualTo: uid)
        .orderBy("date", descending: true) // 🟢 يترتب بالتاريخ
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList(),
        );
  }

  /// ✅ Stream للدخل
  Stream<List<TransactionModel>> get incomesStream {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection("incomes")
        .where("userId", isEqualTo: uid)
        .orderBy("date", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList(),
        );
  }

 Stream<List<TransactionModel>> getExpensesByCategory(String categoryId,) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return const Stream.empty();

  return _firestore
      .collection("expenses")
      .where("categoryId", isEqualTo: categoryId)
      .where("userId", isEqualTo: uid) // 🟢 فلترة باليوزر الحالي
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList(),
      );
}

}
