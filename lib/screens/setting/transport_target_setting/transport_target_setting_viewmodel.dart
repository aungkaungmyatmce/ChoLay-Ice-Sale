import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/models/app_error.dart';
import '../../../core/models/targets/sale_target.dart';
import '../../../core/models/targets/transport_target.dart';
import '../../../core/repositories/target_repository.dart';
import '../../../di/get_it.dart';

class TransportTargetSettingViewModel with ChangeNotifier {
  TargetRepository targetRepository = getItInstance<TargetRepository>();

  List<TransportTarget> transportTargetList = [];
  AppError appError = AppError(AppErrorType.initial);
  TransportTargetSettingViewModel() {
    getData();
  }

  Future<void> getData() async {
    addInitialTargets();
    appError = AppError(AppErrorType.loading);
    Either response = await targetRepository.getTransportTargetList(
        tranMonth: DateTime.now());

    response.fold(
      (l) {
        appError = AppError(AppErrorType.initial);
      },
      (r) {
        appError = AppError(AppErrorType.initial);

        return transportTargetList = r;
      },
    );

    notifyListeners();
  }

  void addInitialTargets() {
    transportTargetList.add(TransportTarget(
      startingTime: DateTime(2020),
      days: 0,
      targetLevel: 1,
    ));
    notifyListeners();
  }

  Future<void> updateTargetList(List<TransportTarget> targetList) async {
    appError = AppError(AppErrorType.loading);
    await targetRepository.updateTransportTargetList(targetList: targetList);
    appError = AppError(AppErrorType.initial);
  }
}
