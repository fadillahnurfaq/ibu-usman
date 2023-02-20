import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/admin/top_up_controller.dart';
import 'package:ibu_usman/shared/utils/currency_format.dart';
import 'package:ibu_usman/shared/utils/style/border_radius.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/widgets/button/primary_button.dart';
import 'package:ibu_usman/views/home/widgets/nominal_card.dart';

import '../../../shared/utils/style/font_weight.dart';

class TopUpView extends StatelessWidget {
  const TopUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: TopUpController.nominal,
      builder: (_, nominal, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Top Up Point User"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: primaryPadding,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: radiusPrimary,
              ),
              child: Column(
                children: [
                  Text(
                    "Pilih nominal:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: medium,
                      color: secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: nominalCard(5000),
                      ),
                      Flexible(
                        flex: 1,
                        child: nominalCard(10000),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: nominalCard(15000),
                      ),
                      Flexible(
                        flex: 1,
                        child: nominalCard(20000),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: nominalCard(25000),
                      ),
                      Flexible(
                        flex: 1,
                        child: nominalCard(30000),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: nominalCard(40000),
                      ),
                      Flexible(
                        flex: 1,
                        child: nominalCard(50000),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: nominalCard(100000),
                      ),
                      Flexible(
                        flex: 1,
                        child: nominalCard(150000),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 130,
            padding: primaryHorizontalSize,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
                bottom: Radius.circular(0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Terima ${CurrencyFormat.convertToIdr(nominal, 2)}",
                  style: TextStyle(
                    color: secondaryColor,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                PrimaryButton(
                  label: "Konfirmasi",
                  onPressed: () {
                    TopUpController.confirmTopUp();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
