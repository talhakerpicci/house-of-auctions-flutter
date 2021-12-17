import 'package:auto_route/auto_route.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/app/app_provider.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';

class BottomNavigationBarWidget extends ConsumerWidget {
  final int pageIndex;
  const BottomNavigationBarWidget({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConvexAppBar(
      curveSize: 90,
      style: TabStyle.fixedCircle,
      backgroundColor: AppColors.blue,
      onTabNotify: (i) {
        final intercept = i == 2;
        if (intercept) {
          context.router.push(const AddItemScreenRoute());
        }
        return !intercept;
      },
      onTap: (index) => ref.read(appProvider.notifier).changePageIndex(index),
      elevation: 0,
      items: [
        const TabItem(icon: Icons.home, title: 'Home'),
        const TabItem(icon: Icons.notification_add_rounded, title: 'My Bids'),
        TabItem(
            icon: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Icon(Icons.add, color: Colors.blue, size: 40),
        )),
        const TabItem(icon: Icons.message, title: 'Inbox'),
        const TabItem(icon: Icons.list_alt_rounded, title: 'My Listings'),
      ],
    );
  }
}
