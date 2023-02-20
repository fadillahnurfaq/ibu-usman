import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/admin/top_up_controller.dart';

import '../../../shared/utils/currency_format.dart';
import '../../../shared/utils/state_util.dart';
import '../../../shared/utils/style/border_radius.dart';
import '../../../shared/utils/style/color.dart';
import '../../../shared/utils/style/font_weight.dart';

Widget nominalCard(double nominal) {
  return Material(
    color: TopUpController.nominal.value == nominal ? whiteColor : cardColor,
    borderRadius: radiusPrimary,
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () {
        TopUpController.handleNominalCard(nominal);
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          CurrencyFormat.convertToIdr(nominal, 2),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: medium,
            color: TopUpController.nominal.value == nominal
                ? cardColor
                : whiteColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
