import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/user/history_point_controller.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/views/home/widgets/history_point_card.dart';

import '../../../services/firebase_auth_service.dart';

class HistoryPointView extends StatelessWidget {
  const HistoryPointView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Riwayat Point"),
          centerTitle: true,
          bottom: TabBar(
            labelColor: secondaryColor,
            indicatorColor: strokeColor,
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Masuk"),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 14.0,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Keluar"),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 14.0,
                      color: Colors.green,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: HistorPointyController.getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Terjadi Kesalahan",
                  style: TextStyle(color: secondaryColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "Belum ada data",
                  style: TextStyle(color: secondaryColor),
                ),
              );
            } else {
              final data = snapshot.data!;
              return TabBarView(
                children: [
                  Padding(
                    padding: primaryPadding,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> item = data.docs[index].data();
                        return item["point"] == 0.0 &&
                                item["user"]["id"] ==
                                    FirebaseAuthService.user?.uid
                            ? HistoryPointCard(item: item, plusOrNegative: "+")
                            : const SizedBox();
                      },
                    ),
                  ),
                  Padding(
                    padding: primaryPadding,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> item = data.docs[index].data();

                        return item["point"] != 0.0 &&
                                item["user"]["id"] ==
                                    FirebaseAuthService.user?.uid
                            ? HistoryPointCard(item: item, plusOrNegative: "-")
                            : const SizedBox();
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
