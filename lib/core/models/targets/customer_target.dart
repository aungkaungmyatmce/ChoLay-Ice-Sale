class CustomerTarget {
  final int numberOfShops;
  final int targetLevel;

  CustomerTarget({required this.numberOfShops, required this.targetLevel});

  factory CustomerTarget.fromJson(dynamic jsonData) {
    return CustomerTarget(
      numberOfShops: jsonData['numberOfShops'],
      targetLevel: jsonData['targetLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['numberOfShops'] = numberOfShops;

    map['targetLevel'] = targetLevel;
    return map;
  }
}
