import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/models/transaction_model.dart';

class TransactionViewmodel extends ChangeNotifier {
  final List<TransactionModel> _transactions = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<TransactionModel> get transactions => _transactions;

  Stream<List<TransactionModel>> get transactionsStream {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection("transactions")
        .where(
          "userId",
          isEqualTo: userId,
        ) // ✅ جلب المعاملات الخاصة بالمستخدم الحالي فقط
        .orderBy("date", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList(),
        );
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await _firestore
          .collection("transactions")
          .doc(transaction.id)
          .set(transaction.toJson());

      _transactions.add(transaction);
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to save transaction: $e");
    }
  }

  Stream<List<TransactionModel>> get expensesStream {
    return transactionsStream.map(
      (allTx) => allTx.where((tx) => tx.type == "expense").toList(),
    );
  }

  Stream<List<TransactionModel>> get incomesStream {
    return transactionsStream.map(
      (allTx) => allTx.where((tx) => tx.type == "income").toList(),
    );
  }
}
