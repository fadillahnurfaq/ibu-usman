import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../controllers/home/admin/home_admin_controller.dart';
import 'firebase_auth_service.dart';

class ChartService {
  static List<ChartData> chart = [];

  static Stream<List<ChartData>> getHistories() {
    List<ChartData> listItem = [];

    try {
      if (FirebaseAuthService.user != null) {}
      return FirebaseFirestore.instance
          .collection('orders')
          .where("status", isEqualTo: "Selesai")
          .snapshots()
          .map((QuerySnapshot list) {
        List<Map<String, dynamic>> result =
            list.docs.map<Map<String, dynamic>>((DocumentSnapshot item) {
          return item.data() as Map<String, dynamic>;
        }).toList();

        listItem.clear();
        result.sort((b, a) => a["updated_at"].compareTo(b["updated_at"]));

        result.map((item) {
          String isDateEvent =
              DateFormat("dd-MMM").format(DateTime.parse(item["updated_at"]));
          int isQuantityEvent = item["quantity"];

          var targetIndex =
              listItem.indexWhere((element) => element.x == isDateEvent);

          isChartData(String date) {
            if (listItem.indexWhere((element) => element.x == date) == -1) {
              return false;
            } else {
              return true;
            }
          }

          if (!isChartData(isDateEvent)) {
            listItem.add(
              ChartData(isDateEvent, isQuantityEvent),
            );
          } else {
            listItem[targetIndex] = ChartData(
              isDateEvent,
              (listItem[targetIndex].y + isQuantityEvent),
            );
          }
        }).toList();

        if (listItem.length > 7) {
          listItem.length = 7;
        }

        listItem.sort((a, b) => a.x.compareTo(b.x));

        return listItem;
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
