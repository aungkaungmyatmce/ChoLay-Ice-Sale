class TransportTarget {
  final DateTime startingTime;
  final int days;
  final int targetLevel;
  final String? pricePool;

  TransportTarget({
    required this.startingTime,
    required this.days,
    required this.targetLevel,
    this.pricePool,
  });

  factory TransportTarget.fromJson(dynamic jsonData) {
    return TransportTarget(
        startingTime:
            DateTime.parse(jsonData['startingTime'].toDate().toString()),
        days: jsonData['days'],
        targetLevel: jsonData['targetLevel'],
        pricePool: jsonData['pricePool']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startingTime'] = startingTime;
    map['days'] = days;
    map['targetLevel'] = targetLevel;
    map['pricePool'] = pricePool;
    return map;
  }
}
