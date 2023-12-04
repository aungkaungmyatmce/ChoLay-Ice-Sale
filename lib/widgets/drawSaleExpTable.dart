import 'package:cholay_ice_sale/common/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';

class DrawSaleExpTable extends StatelessWidget {
  const DrawSaleExpTable({
    Key? key,
    required this.tableDataList,
  }) : super(key: key);

  final List<Map> tableDataList;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: DataTable(
        columnSpacing: 35,
        dividerThickness: 0.000001,
        dataRowHeight: 27,
        headingRowHeight: 25,
        columns: [
          DataColumn(
              label: const Text('Date',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          DataColumn(
              label: const Text('Sale',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          DataColumn(
              label: const Text('Expense',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          DataColumn(
              label: const Text('NetProfit',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
        ],
        rows: tableDataList.map((data) {
          String sale = data['totalSale'];
          String expense = data['totalExpense'];
          String netIncome = data['netIncome'];
          return DataRow(cells: <DataCell>[
            DataCell(Text(data['date'], style: secondaryTextStyle())),
            DataCell(Text(sale.formatWithCommas(),
                textAlign: TextAlign.end, style: secondaryTextStyle())),
            DataCell(Text(expense.formatWithCommas(),
                textAlign: TextAlign.end, style: secondaryTextStyle())),
            DataCell(Text(netIncome.formatWithCommas(),
                textAlign: TextAlign.end, style: secondaryTextStyle())),
          ]);
        }).toList(),
      ),
    );
  }
}
