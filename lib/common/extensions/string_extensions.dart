import '../../screens/language/app_localizations.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String intelliTrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }

  String numTrim() {
    return length > 6 ? '${substring(0, 16)}...' : this;
  }

  String formatWithCommas() {
    final regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return replaceAllMapped(regExp, (Match match) => '${match[1]},');
  }

  String t(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this)!;
  }

  String tOrderHabit(BuildContext context) {
    return AppLocalizations.of(context)!.translateOrderHabit(this)!;
  }

  String tLastOrder(BuildContext context) {
    return AppLocalizations.of(context)!.translateLastOrder(this)!;
  }
}
