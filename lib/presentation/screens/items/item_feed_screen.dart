import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/add_item/add_item_provider.dart';
import 'package:house_of_auctions/application/items/items_provider.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/bar/bar_helper.dart';
import 'package:house_of_auctions/presentation/screens/error_screen.dart';
import 'package:house_of_auctions/presentation/widgets/core/search_app_bar_widget.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_card.dart';

class ItemFeedScreen extends ConsumerWidget {
  const ItemFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemsStateNotifierProvider);
    /* ref.read(itemsStateNotifierProvider.notifier).getItems(); */
    ref.listen(addItemStateNotifierProvider, (stateBefore, stateAfter) {
      if (stateAfter is ItemSuccess) {
        Navigator.pop(context);
        ref.read(itemsStateNotifierProvider.notifier).getItems();
        BarHelper.showAlert(
          AutoRouter.of(context).navigatorKey.currentContext!,
          alert: stateAfter.alert,
          showAboveBottomBar: true,
        );
      }
    });
    return Scaffold(
      appBar: const SearchAppbarWidget(),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (items) => RefreshIndicator(
          onRefresh: () => ref.read(itemsStateNotifierProvider.notifier).getItems(),
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 0.75,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemCard(
                item: items[index],
              );
            },
          ),
        ),
        failed: (alert) => ErrorScreen(
          onPressed: () => ref.read(itemsStateNotifierProvider.notifier).getItems(),
        ),
      ),
    );
  }
}
