import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/models/transaction_model.dart';

class TransactionViewmodel extends ChangeNotifier {
  final List<TransactionModel> _transactions = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<TransactionModel> get transactions => _transactions;

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
}
