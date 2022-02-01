import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/bid/bid_provider.dart';
import 'package:house_of_auctions/application/items/items_provider.dart';
import 'package:house_of_auctions/application/user/user_provider.dart';
import 'package:house_of_auctions/presentation/screens/empty_screen.dart';
import 'package:house_of_auctions/presentation/screens/error_screen.dart';
import 'package:house_of_auctions/presentation/widgets/bid/item_earned_card.dart';

class ItemsEarnedScreen extends ConsumerWidget {
  const ItemsEarnedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bidState = ref.watch(bidStateNotifierProvider);
    final userId = (ref.read(userStateNotifierProvider) as UserLoaded).user.id;
    return Scaffold(
      backgroundColor: Colors.white,
      body: bidState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (bids) {
          var items = (ref.read(itemsStateNotifierProvider) as ItemsLoaded).items;
          items = items.where((item) {
            final endDate = DateTime.parse(item.endDate);
            final now = DateTime.now();

            if (now.isAfter(endDate) && item.buyerId == userId) {
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
                return ItemEarnedCard(
                  item: items[index],
                  bid: highestBid,
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
