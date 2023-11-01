import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseTransaction {
  final String tranId;
  final String expenseName;
  final int amount;
  final DateTime tranDate;

  ExpenseTransaction(
      {required this.tranId,
      required this.expenseName,
      required this.amount,
      required this.tranDate});

  factory ExpenseTransaction.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data() as Map<String, dynamic>;
    return ExpenseTransaction(
      tranId: json.id,
      expenseName: jsonData['expenseName'],
      amount: jsonData['amount'],
      tranDate: jsonData['tranDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expenseName'] = expenseName;
    map['amount'] = amount;
    map['tranDate'] = tranDate;
    return map;
  }
}
