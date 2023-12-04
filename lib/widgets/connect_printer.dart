import 'package:cholay_ice_sale/common/constants/style.dart';
import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/core/services/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/printer_service.dart';

class ConnectPrinter extends StatefulWidget {
  const ConnectPrinter({super.key});

  @override
  State<ConnectPrinter> createState() => _ConnectPrinterState();
}

class _ConnectPrinterState extends State<ConnectPrinter> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PrinterService>(builder: (_, controller, __) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Connect Printer",
                        textScaleFactor: 1.3,
                        style:
                            secondaryTextStyle(color: AppColor.secondaryColor)),
                    Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            minimumSize: const Size(0, 30),
                          ),
                          onPressed: () async {
                            await controller.scan();
                            if (controller.scannedDevices.isEmpty) {
                              UIHelper.showSuccessFlushBar(
                                  context,
                                  TranslationConstants.turnOnBluetooth
                                      .t(context),
                                  icon: Icons.bluetooth,
                                  color: Colors.black54);
                            }
                          },
                          child: Text(
                            "Scan",
                            style: secondaryTextStyle(
                                size: 14, color: AppColor.primaryColor),
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            minimumSize: const Size(0, 30),
                          ),
                          onPressed: controller.connected &&
                                  controller.currentDevice != null
                              ? () => controller.disconnect()
                              : null,
                          child: Text(
                            "Disconnect",
                            style: secondaryTextStyle(
                                size: 14, color: AppColor.secondaryColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Divider(color: Colors.black, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    controller.scanning
                        ? const Center(child: ScanLoadingWiget())
                        : controller.scannedDevices.isEmpty
                            ? const Text("No Device Found")
                            : Column(
                                children: controller.scannedDevices
                                    .map(
                                      (e) => Card(
                                        color: AppColor.primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14.0)),
                                        child: ListTile(
                                          title: Text(e.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Text(e.address),
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsetsDirectional
                                                  .symmetric(
                                                  horizontal: 10, vertical: 0),
                                          trailing: controller.connected &&
                                                  controller.currentDevice
                                                          ?.address ==
                                                      e.address
                                              ? TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.white),
                                                  child: const Text(
                                                    "Connected",
                                                  ),
                                                  onPressed: () {
                                                    controller.connect(e);
                                                  },
                                                )
                                              : TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor: AppColor
                                                          .secondaryColor),
                                                  child: const Text(
                                                    "Connect",
                                                  ),
                                                  onPressed: () {
                                                    controller.connect(e);
                                                  },
                                                ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

// Searching
                    if (controller.scanning)
                      const Text("Searching Printers",
                          style: TextStyle(color: Colors.lightBlue)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
