import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:cholay_ice_sale/core/models/transactions/sale_transaction.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../widgets/connect_printer.dart';

BluePrintPos bluePrint = BluePrintPos.instance;

class PrinterService extends ChangeNotifier with PrinterHandler {
  bool connected = false;
  bool scanning = false;
  BlueDevice? currentDevice;

  List<BlueDevice> scannedDevices = [];

  Future<void> connect(BlueDevice device) async {
    await bluePrint.connect(device);
    connected = true;
    currentDevice = device;
    notifyListeners();
  }

  Future<void> disconnect() async {
    await bluePrint.disconnect();
    connected = false;
    currentDevice = null;
    notifyListeners();
  }

  Future<void> scan() async {
    scanning = true;
    notifyListeners();

    scannedDevices.clear();
    scannedDevices = await searchDevices();

    scanning = false;
    notifyListeners();
  }

  Future<void> showScanSheet(BuildContext context) async {
    if (currentDevice == null) scan();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      barrierColor: Colors.black12,
      enableDrag: true,
      builder: (_) => const ConnectPrinter(),
    );
  }
}

class ScanLoadingWiget extends StatefulWidget {
  const ScanLoadingWiget({super.key});

  @override
  State<ScanLoadingWiget> createState() => ScanLoadingWigetState();
}

class ScanLoadingWigetState extends State<ScanLoadingWiget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: AnimatedBuilder(
          animation: animation,
          builder: (_, __) {
            return CircleAvatar(
              radius: 60 + (40 * animation.value),
              backgroundColor: Colors.white30,
              child: CircleAvatar(
                radius: 60 - (10 * animation.value),
                backgroundColor: Colors.white,
                child: Icon(Icons.bluetooth_searching,
                    size: 40, color: Colors.green),
              ),
            );
          }),
    );
  }
}

mixin PrinterHandler {
  Future<List<BlueDevice>> searchDevices() async {
    List<BlueDevice> discoveredDevices = [];
    bool isOn = await BluetoothPrint.instance.isOn;
    if (isOn) {
      try {
        discoveredDevices = await bluePrint.scan();
      } catch (error) {
        // dd(
        //   'Error while starting scan: $error',
        // );
      }
    } else {
      Get.snackbar(
        "Information",
        "Please Open Your Device Bluetooth",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
      );
    }

    return discoveredDevices;
  }

  Future<void> printReceipt(
    List<SaleTransaction> saleTransactionList,
  ) async {
    final name = 'ချိုလေး';
    final businessType = "ရေသန့်ရေခဲ";
    final phoneOne = "09-969815183 ";
    final phoneTwo = "09-793388991";
    final address = "အနီးစခန်း ပြင်ဦးလွင်";
    final closeText = "ကျေးဇူးတင်ပါသည်";
    final paperSizeString = "58";
    final paperSize = paperSizeString == "58" ? PaperSize.mm58 : PaperSize.mm80;
    int totalPrice = 0;

    final receipt = NiceBarReceipt(saleTransactionList.first.tranDate,
        saleTransactionList.first.customerName,
        name: name,
        businessType: businessType,
        phoneOne: phoneOne,
        phoneTwo: phoneTwo,
        address: address,
        closeText: closeText);

    saleTransactionList.forEach((element) {
      totalPrice += element.totalPrice;
      receipt.addItem(element);
    });
    //
    // if ((order.discount != null && order.discount! > 0) ||
    //     (order.tag != null && order.tag! > 0)) {
    //   receipt.addMeta(
    //       "Sub Total", "${NumberFormat().format(order.amount)} Kyats");
    // }
    //
    // if (order.discount != null && order.discount! > 0) {
    //   receipt.addMeta("Discount", NumberFormat().format(order.discount ?? 0));
    // }
    //
    // if (order.tag != null && order.tag! > 0) {
    //   receipt.addMeta("Tax", "${NumberFormat().format(order.tag)} Kyats");
    // }
    //
    // if (order.warrentyMonths != null && order.warrentyMonths! > 0) {
    //   receipt.addMeta(
    //       "Warranty", "${NumberFormat().format(order.warrentyMonths)} Months");
    // }
    //
    // if ((order.discount != null && order.discount! > 0) ||
    //     (order.tag != null && order.tag! > 0)) {
    //   receipt.addDivider();
    // }
    //
    receipt.addMeta("Total", "${NumberFormat().format(totalPrice)} Kyats");

// final imageBytes = await rootBundle.load("assets/app_icon.jpg");
// final bytes = imageBytes.buffer.asUint8List();

    await bluePrint.printReceiptText(receipt,
        paperSize: paperSize, useCut: true, useRaster: true);
  }
}

class NiceBarReceipt extends ReceiptSectionText {
  final DateTime created;
  final String tableNumber;
  String items = '';
  String meta = '';

  final String thankYou = '<div class="center textLarge"> Thank You </div>';
  final String name;
  final String businessType;
  final String phoneOne;
  final String phoneTwo;
  final String address;
  final String closeText;

  NiceBarReceipt(this.created, this.tableNumber,
      {required this.name,
      required this.businessType,
      required this.phoneOne,
      required this.phoneTwo,
      required this.address,
      required this.closeText});

  @override
  String get content => '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      body {
        padding: 0;
        margin: 0;
        width: 100%;
      }

      pre {
        font-family: sans-serif;
        font-size:1.4em;
      }

      hr {
              border-top: 2px dashed black;
          }

      .center {
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        font-weight: bold;
        font-size:1.2em;
      }

      .spaceBetween {
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        font-weight: bold;
        font-size: 1.2em;
      }


      .alignLeft {
        width: 100%;
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        justify-content: start;
        align-items: center;
        font-weight: bold;
        font-size: 1.2em;
        line-height: 1.7;
        text-overflow: ellipsis;
      }

      .alignRight {
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: end;
        align-items: center;
        font-weight: bold;
        font-size: 1em;
      }



      .headOne {
        font-size: 2.0em;
      }
      .headTwo {
        font-size: 1.8em;
      }
      .headThree {
        font-size: 1.6em;
      }

      .bold {
        font-weight: bold;
      }


      .textLarge{
        font-size:1.3em;
      }

      .textNormal{
        font-size:1.2em;
      }
      .textSmall {
        font-size: 0.9em;
      }
      .textXSmall{
        font-size: 0.8em;
      }
      .textOverFlow {
        width: 33%;
        font-weight: bold;
        font-size: 1em;
      }
      .textAlignCenter{
        text-align: center;
      }
      .textAlignEnd{
        text-align: end;
      }

      td{
        word-wrap: break-word;
        width: 30%;
      }

    </style>
  </head>
  <body>


<div class="headOne center bold" style="text-align:center;">$name</div>
<div class=center bold" style="font-size:1.2em;text-align:center;">$businessType</div>

<div class="center" style="font-size: 1em;text-align:center;">$address</div>
<br>

<div class="alignLeft" style="font-size:1.3em">Ph : $phoneOne , $phoneTwo</div>

<div class="alignLeft" style="font-size:1.2em"><span>Date :  ${DateFormat("d/M/yyy   hh:mm a").format(created)}</span></div>

<div class="alignLeft" style="font-size:1.2em"><span> $tableNumber</span></div>

<hr>


  <table style="width:100%;">
      <thead style="border-collapse: collapse; border-bottom: 1px solid red">
        <tr>
          <th style="width: 40%; text-align: start;font-size:1.3em;">Item</th>
          <th style="width: 30%; text-align: center;font-size:1.3em;">Qty</th>
          <th style="width: 30%; text-align: end;font-size:1.3em;">Price</th>
        </tr>
      </thead>
      <tbody>
        $items
      </tbody>
  </table>



  <hr>

  $meta

  <div style="text-align:center;font-size:1.2em">$closeText</div>
  $thankYou


  </body>
</html>
''';

  void addItem(SaleTransaction item) {
    items += getItemHtml(item);
  }

  void addMeta(String name, String value) {
    meta += getMetaHtml(name, value);
  }

  void addDivider() {
    meta += getDividerHtml();
  }

  String getItemHtml(SaleTransaction product) {
    bool isWithChildren =
        false; //item.children != null && item.children!.isNotEmpty;
    num singlePrice = (product.price! * product.quantity);
    num withChildrenPrice = 444; // item.getTotalChildren();

    if (!isWithChildren && singlePrice <= 0) {
      return "";
    }

    return '''<tr>
          <td style="text-align: start;font-size:1.3em;font-weight:bold;margin-right:20px;">${product.productName}</td>
          <td style="text-align: center;font-size:1.3em;font-weight:bold;">${isWithChildren ? "Group" : "${product.quantity}x${product.price}"}</td>
          <td style="text-align: end;font-size:1.3em;font-weight:bold;">${NumberFormat().format(isWithChildren ? withChildrenPrice : singlePrice)}</td>
        </tr>''';
  }

  String getMetaHtml(String name, String value) {
    return '''<div class="spaceBetween">
      <span style="font-size: 1.3em;">$name</span>
      <span style="font-size: 1.3em;">$value</span>
    </div>''';
  }

  String getDividerHtml() {
    return '''
<hr>
''';
  }
}
