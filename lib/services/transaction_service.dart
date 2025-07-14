// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/item_model.dart';
import 'package:flutter/material.dart';

class TransactionService extends ChangeNotifier {
  int total = 0;
  DateTime date = DateTime.now();

  final db = FirebaseFirestore.instance;

  void setTotal(int value) {
    total = value;
    notifyListeners();
  }

  Future<void> create(List<Item> items) async {
    try {
      final total = items.fold(0, (total, item) => total + item.subTotal);

      final transactionRef = await db.collection('transactions').add({
        'total': total,
        'date': Timestamp.now(),
        'items': items.map((item) => item.toMap()).toList(),
      });

      final batch = db.batch();

      for (final item in items) {
        final itemRef = transactionRef.collection('items').doc();
        batch.set(itemRef, item.toMap());
      }

      await batch.commit();
    } catch (e, stack) {
      print('🔥 Gagal create transaction: $e');
      print(stack);
    }
  }

  Future<List<QueryDocumentSnapshot>> getTransactions() async {
    final snapshot = await db
        .collection('transactions')
        .orderBy(
          'date',
          descending: true,
        )
        .get();

    return snapshot.docs;
  }
}
