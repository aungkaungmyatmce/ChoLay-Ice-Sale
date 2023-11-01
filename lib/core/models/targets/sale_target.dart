class SaleTarget {
  final String productName;
  final int targetAmount;
  final int targetLevel;

  SaleTarget({
    required this.productName,
    required this.targetAmount,
    required this.targetLevel,
  });

  factory SaleTarget.fromJson(dynamic jsonData) {
    return SaleTarget(
      productName: jsonData['productName'],
      targetAmount: jsonData['targetAmount'],
      targetLevel: jsonData['targetLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productName'] = productName;
    map['targetAmount'] = targetAmount;
    map['targetLevel'] = targetLevel;
    return map;
  }
}
