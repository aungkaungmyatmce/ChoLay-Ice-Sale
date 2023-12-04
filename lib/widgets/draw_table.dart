import 'package:cholay_ice_sale/common/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';

class DrawTable extends StatelessWidget {
  const DrawTable({
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
              label: SizedBox(
            width: width / 5,
            child: const Text('Name',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          )),
          if (tableDataList.first['amount'] != null)
            DataColumn(
                label: SizedBox(
              width: width / 5,
              child: const Text('Amount',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            )),
          DataColumn(
              label: SizedBox(
            width: width / 5,
            child: const Text('Price',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          )),
        ],
        rows: tableDataList.map((data) {
          String price = data['price'];
          return DataRow(cells: <DataCell>[
            DataCell(SizedBox(
              width: width / 5,
              child: Text(data['productName'], style: secondaryTextStyle()),
            )),
            if (data['amount'] != null)
              DataCell(SizedBox(
                width: width / 5,
                child: Text(data['amount'],
                    textAlign: TextAlign.end, style: secondaryTextStyle()),
              )),
            DataCell(SizedBox(
              width: width / 5,
              child: Text(price.formatWithCommas(),
                  textAlign: TextAlign.end, style: secondaryTextStyle()),
            )),
          ]);
        }).toList(),
      ),
    );
  }
}
