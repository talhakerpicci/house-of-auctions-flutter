import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_sold_card.dart';

class ItemsSoldScreen extends StatelessWidget {
  const ItemsSoldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        children: const [
          ItemSoldCard(),
        ],
      ),
    );
  }
}
