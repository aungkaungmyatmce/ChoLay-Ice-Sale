class ProductTransaction {
  final String productName;
  final int amount;
  final int? price;

  ProductTransaction(
      {required this.productName, required this.amount, this.price});

  factory ProductTransaction.fromJson(dynamic json) {
    return ProductTransaction(
      productName: json['productName'],
      price: json['price'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productName'] = productName;
    map['price'] = price;
    map['amount'] = amount;
    return map;
  }
}
