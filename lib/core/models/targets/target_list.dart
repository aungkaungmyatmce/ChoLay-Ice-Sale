import 'package:cholay_ice_sale/core/models/targets/sale_target.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TargetList {
  final List<SaleTarget> targets;

  TargetList({required this.targets});
}
