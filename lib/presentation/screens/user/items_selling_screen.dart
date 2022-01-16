import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/items/items_provider.dart';
import 'package:house_of_auctions/application/user/user_provider.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/presentation/screens/empty_screen.dart';
import 'package:house_of_auctions/presentation/screens/error_screen.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_selling_card.dart';

class ItemsSellingScreen extends ConsumerWidget {
  const ItemsSellingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateNotifierProvider);
    final user = userState is UserLoaded ? userState.user : UserModel.initial();
    final state = ref.watch(itemsStateNotifierProvider);
    return Scaffold(
      body: state.when(
        // TODO: YOU COULD ADD NOT FOUND STATE AND SHOW EMPTY SCREEN THAT WAY
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (items) {
          items = items.where((item) => item.userId == user.id).toList();
          items = items.where((item) {
            final endDate = DateTime.parse(item.endDate);
            final now = DateTime.now();
            if (item.userId == user.id && now.isBefore(endDate)) {
              return true;
            }
            return false;
          }).toList();
          if (items.isEmpty) {
            return const EmptyScreen(
              message: 'Try selling some items!',
              icon: Icons.foundation,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => ItemSellingCard(
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
