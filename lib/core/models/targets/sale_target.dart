class SaleTarget {
  final String productName;
  final List<TargetInfo> targets;

  SaleTarget({
    required this.productName,
    required this.targets,
  });

  factory SaleTarget.fromJson(dynamic jsonData) {
    return SaleTarget(
        productName: jsonData['productName'],
        targets: jsonData['targets']
            .map((target) => TargetInfo.fromJson(target))
            .toList()
            .cast<TargetInfo>());
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productName'] = productName;
    map['targets'] = targets.map((target) => target.toJson());

    return map;
  }
}

class TargetInfo {
  final int amount;
  final int level;
  final String? pricePool;

  TargetInfo({required this.amount, required this.level, this.pricePool});
  factory TargetInfo.fromJson(dynamic jsonData) {
    return TargetInfo(
      amount: jsonData['amount'],
      level: jsonData['level'],
      pricePool: jsonData['pricePool'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['level'] = level;
    map['pricePool'] = pricePool;
    return map;
  }
}
