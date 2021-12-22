import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_sold_card.dart';

class ItemsSoldScreen extends StatelessWidget {
  const ItemsSoldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemList = <Map>[
      {
        'name': 'Dell Gaming G15 5510',
        'picture': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjefFODtEBb6DmzzXDGw1nktatDmcRnaUbFRzOfWb4ouztBjVSxa9YYA0XKpbezu8oTLw&usqp=CAU',
        'price': '13200 Tl',
        'soldDate': 'Sold at 12/10/21',
      },
      {
        'name': 'RX 580 Ekran Karti',
        'picture': 'https://cdn.vatanbilgisayar.com/Upload/PRODUCT/msi/thumb/v2-86368-9_large.jpg',
        'price': '9200 Tl',
        'soldDate': 'Sold at 29/12/21',
      },
    ];
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        itemCount: itemList.length,
        itemBuilder: (context, index) => ItemSoldCard(
          itemDetail: itemList[index],
        ),
      ),
    );
  }
}
