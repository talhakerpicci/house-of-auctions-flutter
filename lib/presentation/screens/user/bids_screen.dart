import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/presentation/screens/user/items_earned_screen.dart';
import 'package:house_of_auctions/presentation/screens/user/my_bids_screen.dart';

class BidsScreen extends ConsumerWidget {
  const BidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Bids'),
          bottom: const TabBar(
            labelColor: AppColors.blue,
            unselectedLabelColor: AppColors.darkGrey,
            tabs: [
              Tab(
                text: 'My Bids',
              ),
              Tab(
                text: 'Items Earned',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyBidsScreen(),
            ItemsEarnedScreen(),
          ],
        ),
      ),
    );
  }
}
