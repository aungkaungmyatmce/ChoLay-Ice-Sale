import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseTransaction {
  final String? tranId;
  final String expenseName;
  final int amount;
  final String? note;
  final DateTime tranDate;

  ExpenseTransaction(
      {this.tranId,
      required this.expenseName,
      required this.amount,
      this.note,
      required this.tranDate});

  factory ExpenseTransaction.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data() as Map<String, dynamic>;
    return ExpenseTransaction(
      tranId: json.id,
      expenseName: jsonData['expenseName'],
      amount: jsonData['amount'],
      note: jsonData['note'],
      tranDate: DateTime.parse(jsonData['tranDate'].toDate().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expenseName'] = expenseName;
    map['amount'] = amount;
    map['note'] = note;
    map['tranDate'] = tranDate;
    return map;
  }
}
