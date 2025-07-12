import 'package:flutter/material.dart';

class Items {
  String name;
  int weight;
  int price;
  int subTotal;

  Items({
    required this.name,
    required this.weight,
    required this.price,
    required this.subTotal,
  });
}

class HomeViewModel extends ChangeNotifier {
  String name = "";
  int weight = 0;
  int price = 0;
  int subTotal = 0;
  List<Items> items = [];

  bool isLoading = false;
  String? errorMessage;

  void setName(String value) {
    name = value;
    if (name.isNotEmpty && weight > 0 && price > 0) {
      subTotal = weight * price;
    }
    notifyListeners();
  }

  void setWeight(int value) {
    weight = value;
    if (name.isNotEmpty && weight > 0 && price > 0) {
      subTotal = weight * price;
    }
    notifyListeners();
  }

  void setPrice(int value) {
    price = value;
    if (name.isNotEmpty && weight > 0 && price > 0) {
      subTotal = weight * price;
    }
    notifyListeners();
  }

  get totalPrice {
    int total = 0;
    for (var item in items) {
      total += item.subTotal;
    }
    return total;
  }

  void reset() {
    name = "";
    weight = 0;
    price = 0;
    subTotal = 0;
    notifyListeners();
  }

  Future<Items> getItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return Items(
      name: name,
      weight: weight,
      price: price,
      subTotal: subTotal,
    );
  }

  Future<bool> save() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    if (name.isNotEmpty && weight > 0 && price > 0) {
      isLoading = false;
      items.add(
        Items(
          name: name,
          weight: weight,
          price: price,
          subTotal: subTotal,
        ),
      );
      reset();
      notifyListeners();
      return true;
    } else {
      errorMessage = 'Data tidak boleh kosong!';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void delete(int index) {
    items.removeAt(index);
    notifyListeners();
  }
}
