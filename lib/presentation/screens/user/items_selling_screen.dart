import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_selling_card.dart';

class ItemsSellingScreen extends StatelessWidget {
  const ItemsSellingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemList = <Map>[
      {
        'name': 'Vantuz S6 Elektrikli Süpürge',
        'picture': 'https://6rk3rbju.rocketcdn.com/image/cdndata/185/1211103/image153.01.06.4925-3.jpg',
        'price': '2200 Tl',
        'numOfBids': '6',
      },
      {
        'name': 'Sari Mont',
        'picture': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDQYQur6M8dRM3DUew1ZMn2kP7sqUWjBtoeg&usqp=CAU',
        'price': '365 Tl',
        'numOfBids': '23',
      },
      {
        'name': 'Sony SP400 Kulaklik',
        'picture': 'https://techcrunch.com/wp-content/uploads/2020/11/DSC09882.jpg?w=1024',
        'price': '850 Tl',
        'numOfBids': '11',
      },
    ];
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        itemCount: itemList.length,
        itemBuilder: (context, index) => ItemSellingCard(
          itemDetail: itemList[index],
        ),
      ),
    );
  }
}
