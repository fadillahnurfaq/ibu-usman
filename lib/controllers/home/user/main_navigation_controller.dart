import 'package:flutter/material.dart';
import 'package:ibu_usman/views/home/user/wishlist_view.dart';

import '../../../views/home/user/history_view.dart';
import '../../../views/home/user/home_view.dart';
import '../../../views/profile/profile_view.dart';

class MainNavigationController {
  static List<Widget> widgetOptions = <Widget>[
    const HomeView(),
    const HistoryView(),
    // const OrderDetailView(),
    const WishListView(),
    const ProfileView(),
  ];

  static ValueNotifier<int> currentIndex = ValueNotifier(0);

  static void onItemTapped(int index) {
    currentIndex.value = index;
  }
}
