import 'package:flutter/material.dart';
import 'package:ibu_usman/services/wishliat_service.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/widgets/is_empty.dart';
import 'package:ibu_usman/views/home/widgets/wishlist_card.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List>(
        valueListenable: WishlistService.wishList,
        builder: (_, wishList, __) {
          if (wishList.isEmpty) {
            return const IsEmpty();
          }
          return SingleChildScrollView(
            padding: primaryPadding,
            child: Column(
              children: wishList.map((e) => WishlistCard(e)).toList(),
            ),
          );
        },
      ),
    );
  }
}
