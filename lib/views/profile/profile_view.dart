import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/user/home_controller.dart';
import 'package:ibu_usman/models/user_model.dart';
import 'package:ibu_usman/services/firebase_auth_service.dart';
import 'package:ibu_usman/shared/utils/currency_format.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/border_radius.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/utils/utility/show_confirmation.dart';
import 'package:ibu_usman/shared/widgets/button/primary_menu_button.dart';
import 'package:ibu_usman/shared/widgets/header_appbar.dart';
import 'package:ibu_usman/views/profile/edit_profile_view.dart';

import '../../controllers/profile/profile_controller.dart';
import '../../shared/utils/style/font_weight.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: primaryPadding,
        child: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: ProfileController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data?.data() == null) {
                return Center(
                  child: Text(
                    "Tidak ada data.",
                    style: TextStyle(fontSize: 15, color: secondaryColor),
                  ),
                );
              } else {
                Map<String, dynamic> item =
                    snapshot.data?.data() as Map<String, dynamic>;
                UserModel data = UserModel.fromJson(item);

                return Column(
                  children: [
                    const HeaderAppBar(label: "Profile Saya", hide: true),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 15.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: radiusPrimary,
                        color: cardColor,
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              "${data.photo}",
                              height: 64,
                              width: 64,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.name}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: semibold,
                                  color: secondaryColor,
                                ),
                              ),
                              Text(
                                "Point : ${CurrencyFormat.convertToIdr(data.point, 2)}",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: secondaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Material(
                        borderRadius: radiusPrimary,
                        color: cardColor,
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: radiusPrimary,
                          ),
                          child: Column(
                            children: [
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.person_outline,
                                  color: secondaryColor,
                                ),
                                label: "Perbarui Profil",
                                onTap: () {
                                  Get.to(
                                      page: EditProfileView(
                                    data: data,
                                  ));
                                },
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.add_card,
                                  color: secondaryColor,
                                ),
                                label: "Top Up Point",
                                onTap: () {
                                  HomeController.scanQrCode();
                                },
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.monetization_on,
                                  color: secondaryColor,
                                ),
                                label: "Riyawat Point",
                                onTap: () {},
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.favorite_outline,
                                  color: secondaryColor,
                                ),
                                label: "Wishlist",
                                onTap: () {},
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: secondaryColor,
                                ),
                                label: "Lihat Pesanan",
                                onTap: () {},
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.call_outlined,
                                  color: secondaryColor,
                                ),
                                label: "Hubungi Penjual",
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Material(
                        borderRadius: radiusPrimary,
                        color: cardColor,
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: radiusPrimary,
                          ),
                          child: Column(
                            children: [
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.settings_outlined,
                                  color: secondaryColor,
                                ),
                                label: "Pengaturan Akun",
                                onTap: () {},
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.book_outlined,
                                  color: secondaryColor,
                                ),
                                label: "Syarat dan Ketentuan",
                                onTap: () {},
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.policy,
                                  color: secondaryColor,
                                ),
                                label: "Kebijakan Pribadi",
                                onTap: () {},
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.help_outline,
                                  color: secondaryColor,
                                ),
                                label: "Pusat Bantuan",
                                onTap: () {},
                              ),
                              PrimaryMenuButton(
                                icon: Icon(
                                  Icons.logout_outlined,
                                  color: secondaryColor,
                                ),
                                label: "Keluar",
                                onTap: () {
                                  showConfirmation(
                                    onPressed: () {
                                      FirebaseAuthService.logout();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
