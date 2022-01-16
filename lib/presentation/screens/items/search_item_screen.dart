import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/items/items_provider.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/screens/error_screen.dart';
import 'package:house_of_auctions/presentation/widgets/item/item_card.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class SearchItemScreen extends ConsumerStatefulWidget {
  const SearchItemScreen({Key? key}) : super(key: key);

  @override
  _SearchItemScreenState createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends ConsumerState<SearchItemScreen> {
  String keyWord = '';

  Widget buildBody() {
    final state = ref.watch(itemsStateNotifierProvider);
    return Column(
      children: [
        Expanded(
          child: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (items) {
              items = (ref.read(itemsStateNotifierProvider) as ItemsLoaded)
                  .items
                  .where(
                    (element) => element.name.toLowerCase().contains(keyWord.toLowerCase()),
                  )
                  .toList();
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1.55,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    item: items[index],
                  );
                },
              );
            },
            failed: (alert) => ErrorScreen(
              onPressed: () => ref.read(itemsStateNotifierProvider.notifier).getItems(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unFocus,
      child: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              width: getSize(context).width,
              height: getSize(context).height,
              child: Column(
                children: [
                  const SpaceH12(),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          blurRadius: 20,
                          offset: const Offset(
                            5,
                            5,
                          ),
                        )
                      ],
                    ),
                    child: Card(
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        /* trailing: SizedBox(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.sort_by_alpha),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {});
                                },
                                child: const Icon(Icons.filter_list),
                              ),
                            ],
                          ),
                        ), */
                        title: TextField(
                          decoration: const InputDecoration.collapsed(hintText: 'Search item...'),
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            setState(() {
                              keyWord = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SpaceH12(),
                  Expanded(
                    child: SizedBox(
                      width: getSize(context).width,
                      child: buildBody(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
