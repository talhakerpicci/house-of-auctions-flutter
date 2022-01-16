import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/items/items_provider.dart';
import 'package:house_of_auctions/application/user/user_provider.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/presentation/screens/empty_screen.dart';
import 'package:house_of_auctions/presentation/screens/error_screen.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_sold_card.dart';

class ItemsSoldScreen extends ConsumerWidget {
  const ItemsSoldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateNotifierProvider);
    final user = userState is UserLoaded ? userState.user : UserModel.initial();
    final state = ref.watch(itemsStateNotifierProvider);
    return Scaffold(
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (items) {
          items = items.where((item) {
            final endDate = DateTime.parse(item.endDate);
            final now = DateTime.now();
            if (item.userId == user.id && endDate.isBefore(now)) {
              return true;
            }
            return false;
          }).toList();
          if (items.isEmpty) {
            return const EmptyScreen(
              message: 'No items sold',
              icon: Icons.foundation,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => ItemSoldCard(
              item: items[index],
            ),
          );
        },
        failed: (alert) => ErrorScreen(
          onPressed: () => ref.read(itemsStateNotifierProvider.notifier).getItems(),
        ),
      ),
    );
  }
}
