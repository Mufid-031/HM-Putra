import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemService extends ChangeNotifier {
  final textEditingController = TextEditingController();
  List<Item> localItems = [];
  String name = '';
  double weight = 0;
  int price = 0;
  int subTotal = 0;

  bool isLoading = false;
  String? errorMessage;

  final db = FirebaseFirestore.instance;

  void setName(String value) {
    name = value;
    textEditingController.text = value;

    if (name.isNotEmpty && weight > 0 && price > 0) {
      final total = weight * price;
      subTotal = total.toInt();
    }
    notifyListeners();
  }

  void setWeight(double value) {
    weight = value;
    if (name.isNotEmpty && weight > 0 && price > 0) {
      final total = weight * price;
      subTotal = total.toInt();
    }
    notifyListeners();
  }

  void setPrice(int value) {
    price = value;
    if (name.isNotEmpty && weight > 0 && price > 0) {
      final total = weight * price;
      subTotal = total.toInt();
    }
    notifyListeners();
  }

  get totalPrice {
    int total = 0;
    for (var item in localItems) {
      total += item.subTotal;
    }
    return total;
  }

  void deleteLocal(int index) {
    localItems.removeAt(index);
    notifyListeners();
  }

  void deleteAllITemsLocal() {
    localItems.clear();
    notifyListeners();
  }

  void reset() {
    name = '';
    weight = 0;
    price = 0;
    subTotal = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<bool> save() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    if (name.isNotEmpty && weight > 0 && price > 0) {
      isLoading = false;
      localItems.add(
        Item(
          name: name,
          weight: weight,
          price: price,
          subTotal: subTotal,
        ),
      );
      notifyListeners();
      return true;
    } else {
      errorMessage = 'Data tidak boleh kosong!';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<List<Item>> getItems() async {
    final snapshot = await db.collection('items').get();

    List<Item> items = snapshot.docs.map((doc) {
      return Item(
        name: doc['name'],
        weight: doc['weight'],
        price: doc['price'],
        subTotal: doc['subTotal'],
      );
    }).toList();

    return items;
  }

  Future<Item?> getItemsById(String id) async {
    final doc = await db.collection('items').doc(id).get();

    if (!doc.exists) {
      return null;
    }

    return Item(
      name: doc['name'],
      weight: doc['weight'],
      price: doc['price'],
      subTotal: doc['subTotal'],
    );
  }

  Future<void> create() async {
    final subTotal = weight * price;
    final newItem = Item(
      name: name,
      weight: weight,
      price: price,
      subTotal: int.fromEnvironment(subTotal.toString()),
    );

    await db.collection('items').add(newItem.toMap());
  }

  Future<void> update(String id) async {
    final subTotal = weight * price;
    final newItem = Item(
      name: name,
      weight: weight,
      price: price,
      subTotal: int.fromEnvironment(subTotal.toString()),
    );

    await db.collection('items').doc(id).update(newItem.toMap());
  }

  Future<void> delete(String id) async {
    await db.collection('items').doc(id).delete();
  }
}
