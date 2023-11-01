class TransportTarget {
  final String startingTime;
  final int days;
  final int targetLevel;

  TransportTarget({
    required this.startingTime,
    required this.days,
    required this.targetLevel,
  });

  factory TransportTarget.fromJson(dynamic jsonData) {
    return TransportTarget(
      startingTime: jsonData['startingTime'],
      days: jsonData['days'],
      targetLevel: jsonData['targetLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startingTime'] = startingTime;
    map['days'] = days;
    map['targetLevel'] = targetLevel;
    return map;
  }
}
