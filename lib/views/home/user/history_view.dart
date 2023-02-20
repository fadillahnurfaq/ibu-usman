import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/user/history_controller.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/views/home/user/history_point_view.dart';
import 'package:ibu_usman/views/home/widgets/history_card.dart';

import '../../../services/firebase_auth_service.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: const Duration(milliseconds: 700),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("History"),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(page: const HistoryPointView());
              },
              icon: Icon(
                Icons.monetization_on,
                color: secondaryColor,
              ),
            ),
          ],
          bottom: TabBar(
            labelColor: secondaryColor,
            // indicatorColor: strokeColor,
            splashBorderRadius: BorderRadius.circular(20),
            indicator: BoxDecoration(
              color: strokeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            unselectedLabelColor: const Color(0xFFc9c9c9),
            tabs: const [
              Tab(
                text: "Dalam Proses",
              ),
              Tab(
                text: "Selesai",
              ),
              Tab(
                text: "Ditolak",
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: HistoryController.getOrders(),
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
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 50),
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = data.docs[index].data();
                      return item["status"] == "Dalam Proses" &&
                              item["user"]["id"] ==
                                  FirebaseAuthService.user?.uid
                          ? HistoryCard(
                              item,
                            )
                          : const SizedBox();
                    },
                  ),
                  ListView.builder(
                    itemCount: data.docs.length,
                    padding: const EdgeInsets.only(bottom: 50),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = data.docs[index].data();
                      return item["status"] == "Selesai" &&
                              item["user"]["id"] ==
                                  FirebaseAuthService.user?.uid
                          ? HistoryCard(
                              item,
                            )
                          : const SizedBox();
                    },
                  ),
                  ListView.builder(
                    itemCount: data.docs.length,
                    padding: const EdgeInsets.only(bottom: 50),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = data.docs[index].data();
                      return item["status"] == "Ditolak" &&
                              item["user"]["id"] ==
                                  FirebaseAuthService.user?.uid
                          ? HistoryCard(
                              item,
                            )
                          : const SizedBox();
                    },
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
