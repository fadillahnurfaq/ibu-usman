import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibu_usman/services/chart_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeAdminController {
  static final TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);

  static List<ChartData> chartData = ChartService.chart;

  static ValueNotifier<int> currentFilter = ValueNotifier(0);

  static void handleFilter(int index) {
    currentFilter.value = index;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOrders() async* {
    yield* FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "Dalam Proses")
        .snapshots();
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
