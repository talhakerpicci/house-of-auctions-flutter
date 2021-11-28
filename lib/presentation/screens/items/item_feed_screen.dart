import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_card.dart';

class ItemFeedScreen extends StatefulWidget {
  const ItemFeedScreen({Key? key}) : super(key: key);

  @override
  _ItemFeedScreenState createState() => _ItemFeedScreenState();
}

class _ItemFeedScreenState extends State<ItemFeedScreen> {
  List<String> urls = [
    'https://pngimg.com/uploads/iphone_13/iphone_13_PNG5.png',
    'https://pngimg.com/uploads/laptop/laptop_PNG101764.png',
    'https://pngimg.com/uploads/headphones/headphones_PNG101980.png',
    'https://pngimg.com/uploads/photo_camera/photo_camera_PNG101639.png',
    'https://pngimg.com/uploads/bmw/bmw_PNG99566.png',
    'https://pngimg.com/uploads/backpack/backpack_PNG6343.png',
    'https://pngimg.com/uploads/vladimir_putin/vladimir_putin_PNG43.png',
    'https://pngimg.com/uploads/hammer/hammer_PNG103357.png',
    'https://pngimg.com/uploads/hoodie/hoodie_PNG45.png',
  ];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.value(null),
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
        ),
        itemCount: urls.length,
        itemBuilder: (context, index) {
          return ItemCard(
            url: urls[index],
          );
        },
      ),
    );
  }
}
