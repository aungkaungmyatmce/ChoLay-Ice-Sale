import 'package:flutter/material.dart';

import '../common/constants/style.dart';
import '../core/models/app_error.dart';

class BodyWidget extends StatelessWidget {
  final AppError appError;
  final Widget child;
  final String? emptyText;
  const BodyWidget({
    super.key,
    required this.appError,
    required this.child,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    if (appError.appErrorType == AppErrorType.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (appError.appErrorType == AppErrorType.database) {
      return Center(
          child: Text(emptyText ?? 'No Data!', style: secondaryTextStyle()));
    }
    return child;
  }
}
