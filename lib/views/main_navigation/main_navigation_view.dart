import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/user/cart_controller.dart';

import '../../controllers/home/user/main_navigation_controller.dart';
import '../../services/cart_service.dart';
import '../../shared/utils/state_util.dart';
import '../../shared/utils/style/color.dart';
import '../../shared/utils/style/font_weight.dart';
import '../../shared/utils/utility/show_alert.dart';
import '../home/user/cart_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  @override
  void initState() {
    CartService.totalQuantity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget cartButton() {
      return ValueListenableBuilder<int>(
          valueListenable: CartService.quantity,
          builder: (_, quantity, __) {
            return FloatingActionButton(
              onPressed: () async {
                if (quantity > 0) {
                  Get.to(page: const CartView());
                  CartService.totalQuantity();
                  CartService.totalPayment();
                  await CartController.getPoint();
                  CartController.paymentMethod = "";
                } else {
                  showAlert("Oppsss", "Tidak ada menu yang akan dipesan");
                }
              },
              backgroundColor: lightColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fastfood,
                    color: cardColor,
                  ),
                  Text(
                    "$quantity",
                    style: TextStyle(
                      fontWeight: bold,
                      color: cardColor,
                    ),
                  ),
                ],
              ),
            );
          });
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        child: SizedBox(
          height: 80.0,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6, // membuat margin
            clipBehavior: Clip.antiAlias,
            child: ValueListenableBuilder<int>(
                valueListenable: MainNavigationController.currentIndex,
                builder: (_, v, __) {
                  return BottomNavigationBar(
                    backgroundColor: cardColor,
                    currentIndex: v,
                    onTap: (value) {
                      MainNavigationController.onItemTapped(value);
                    },
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: whiteColor,
                    unselectedItemColor: lightColor,
                    selectedLabelStyle: TextStyle(fontWeight: bold),
                    items: const [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Icon(Icons.home_outlined),
                        ),
                        label: 'Beranda',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Icon(Icons.history_outlined),
                        ),
                        label: 'Riwayat',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Icon(Icons.favorite_border),
                        ),
                        label: 'Wishlist',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Icon(Icons.person_outline_rounded),
                        ),
                        label: 'Profil',
                      ),
                    ],
                  );
                }),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: ValueListenableBuilder<int>(
          valueListenable: MainNavigationController.currentIndex,
          builder: (_, v, __) {
            return MainNavigationController.widgetOptions.elementAt(v);
          }),
    );
  }
}
