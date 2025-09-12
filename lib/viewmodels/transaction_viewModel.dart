import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  /// ✅ مصاريف
  Stream<List<TransactionModel>> get expensesStream {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection("expenses")
        .where("userId", isEqualTo: uid)
        //.orderBy("date", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList(),
        );
  }

  /// ✅ دخل
  Stream<List<TransactionModel>> get incomesStream {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection("incomes")
        .where("userId", isEqualTo: uid)
        // .orderBy("date", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList(),
        );
  }
}
