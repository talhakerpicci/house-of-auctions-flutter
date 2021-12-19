import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_selling_card.dart';

class ItemsSellingScreen extends StatelessWidget {
  const ItemsSellingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        children: const [
          ItemSellingCard(),
        ],
      ),
    );
  }
}
