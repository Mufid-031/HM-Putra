class Item {
  String name;
  double weight;
  int price;
  int subTotal;

  Item({
    required this.name,
    required this.weight,
    required this.price,
    required this.subTotal,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weight': weight,
      'price': price,
      'subTotal': subTotal,
    };
  }
}
