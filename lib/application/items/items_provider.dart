import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:house_of_auctions/domain/interfaces/i_items_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/item/item_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';

part 'items_provider.freezed.dart';
part 'items_state.dart';

final itemsStateNotifierProvider = StateNotifierProvider<ItemsStateNotifier, ItemsState>(
  (ref) => ItemsStateNotifier(getIt<IItemsRepository>()),
);

class ItemsStateNotifier extends StateNotifier<ItemsState> {
  final IItemsRepository _itemsRepository;
  ItemsStateNotifier(this._itemsRepository) : super(const ItemsState.loading());

  Future<void> getItems() async {
    state = const ItemsState.loading();

    final response = await _itemsRepository.getItems();

    response.pick(
      onError: (error) {
        state = ItemsState.failed(alert: error);
      },
      onData: (items) {
        state = ItemsState.loaded(items: items);
      },
    );
  }
}
