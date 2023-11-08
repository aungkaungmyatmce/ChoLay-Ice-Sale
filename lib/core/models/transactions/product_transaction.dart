class ProductInfo {
  final String productName;
  final int quantity;
  final int? price;

  ProductInfo({required this.productName, required this.quantity, this.price});

  factory ProductInfo.fromJson(dynamic json) {
    return ProductInfo(
      productName: json['productName'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productName'] = productName;
    map['price'] = price;
    map['quantity'] = quantity;
    return map;
  }
}
