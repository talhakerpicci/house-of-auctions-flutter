import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/presentation/screens/user/items_selling_screen.dart';
import 'package:house_of_auctions/presentation/screens/user/items_sold_screen.dart';

class MyItemsScreen extends StatelessWidget {
  const MyItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Listings'),
          bottom: const TabBar(
            labelColor: AppColors.blue,
            unselectedLabelColor: AppColors.darkGrey,
            tabs: [
              Tab(
                text: 'Selling',
              ),
              Tab(
                text: 'Sold',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ItemsSellingScreen(),
            ItemsSoldScreen(),
          ],
        ),
      ),
    );
  }
}
