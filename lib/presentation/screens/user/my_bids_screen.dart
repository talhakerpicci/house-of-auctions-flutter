import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_card.dart';

class MyBidsScreen extends StatelessWidget {
  const MyBidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urls = <String>[
      'https://pngimg.com/uploads/iphone_13/iphone_13_PNG5.png',
      'https://pngimg.com/uploads/laptop/laptop_PNG101764.png',
      'https://pngimg.com/uploads/headphones/headphones_PNG101980.png',
      'https://pngimg.com/uploads/photo_camera/photo_camera_PNG101639.png',
      'https://pngimg.com/uploads/bmw/bmw_PNG99566.png',
      'https://pngimg.com/uploads/backpack/backpack_PNG6343.png',
      'https://pngimg.com/uploads/hoodie/hoodie_PNG45.png',
    ];
    final prices = <String>[
      '9500 TL',
      '13240 TL',
      '560 TL',
      '1200 TL',
      '350000 TL',
      '96 TL',
      '125 TL',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Bids'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 0.75,
        ),
        itemCount: urls.length,
        itemBuilder: (context, index) {
          return ItemCard(
            url: urls[index],
            price: prices[index],
          );
        },
      ),
    );
  }
}
