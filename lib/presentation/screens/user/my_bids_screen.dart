import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/bid/bid_provider.dart';
import 'package:house_of_auctions/application/items/items_provider.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/presentation/screens/empty_screen.dart';
import 'package:house_of_auctions/presentation/screens/error_screen.dart';
import 'package:house_of_auctions/presentation/widgets/bid/bid_card.dart';

class MyBidsScreen extends ConsumerWidget {
  const MyBidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bidState = ref.watch(bidStateNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: bidState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (bids) {
          var items = (ref.read(itemsStateNotifierProvider) as ItemsLoaded).items;
          items = items.where((item) {
            final endDate = DateTime.parse(item.endDate);
            final now = DateTime.now();

            if (now.isBefore(endDate)) {
              return true;
            }
            return false;
          }).toList();

          final bids = (bidState as BidsLoaded).bids;
          final uniqueBids = [];

          for (final bid in bids) {
            if (!uniqueBids.contains(bid.itemId)) {
              uniqueBids.add(bid.itemId);
            }
          }

          items = items.where((element) => uniqueBids.contains(element.id)).toList();

          if (items.isEmpty) {
            return const EmptyScreen(
              message: 'Try bidding for some items!',
              icon: Icons.foundation,
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final highestBid = bids.reduce((a, b) {
                  if (a.bidAmount > a.bidAmount) {
                    return a;
                  } else {
                    return b;
                  }
                });
                return BidCard(
                  item: items[index],
                  bid: highestBid,
                  onPressed: () {
                    context.router.push(FeedItemDetailScreenRoute(item: items[index]));
                  },
                );
              });
        },
        failed: (alert) => ErrorScreen(
          onPressed: () => ref.read(itemsStateNotifierProvider.notifier).getItems(),
        ),
      ),
    );
  }
}
