import 'package:cholay_ice_sale/commom/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart'; // require flushbar package

class UIHelper {
  static void _buildFlushBar(BuildContext context,
      {String? message, IconData? icon, Color? color}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.values[FlushbarPosition.TOP.index],
      flushbarStyle: FlushbarStyle.FLOATING,
      message: message ?? '',
      icon: Icon(
        icon ?? Icons.done,
        size: 28.0,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 3),
      //leftBarIndicatorColor: color ?? Colors.white,
      backgroundColor: color ?? AppColor.primaryColor,
    ).show(context);
  }

  static void showSuccessFlushBar(BuildContext context, String message,
      {IconData? icon, Color? color}) {
    _buildFlushBar(context, message: message, icon: icon, color: color);
  }
}
