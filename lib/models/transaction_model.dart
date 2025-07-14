import 'package:first_app_flutter/models/item_model.dart';

class Transaction {
  final String? id;
  final int total;
  final DateTime date;
  final List<Item> items;

  Transaction({
    this.id,
    required this.total,
    required this.date,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'date': date,
    };
  }
}
