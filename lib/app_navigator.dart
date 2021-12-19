import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/app/app_provider.dart';
import 'package:house_of_auctions/presentation/screens/chat/inbox_people_screen.dart';
import 'package:house_of_auctions/presentation/screens/items/item_feed_screen.dart';
import 'package:house_of_auctions/presentation/screens/user/my_bids_screen.dart';
import 'package:house_of_auctions/presentation/screens/user/my_items_screen.dart';
import 'package:house_of_auctions/presentation/widgets/core/bottom_nav_bar.dart';

class AppNavigator extends ConsumerWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) {
        final index = ref.watch(appProvider)! as int;
        return Scaffold(
          body: _getBodyViews().elementAt(index),
          bottomNavigationBar: BottomNavigationBarWidget(
            pageIndex: index,
          ),
        );
      },
    );
  }

  List<Widget> _getBodyViews() {
    return [
      const ItemFeedScreen(),
      const MyBidsScreen(),
      const SizedBox(),
      const InboxPeopleScreen(),
      const MyItemsScreen(),
    ];
  }
}
