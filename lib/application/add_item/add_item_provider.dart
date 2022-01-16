import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:house_of_auctions/domain/interfaces/i_items_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/item/item_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:image_picker/image_picker.dart';

part 'add_item_provider.freezed.dart';
part 'add_item_state.dart';

final addItemStateNotifierProvider = StateNotifierProvider<AddItemStateNotifier, AddItemState>(
  (ref) => AddItemStateNotifier(getIt<IItemsRepository>()),
);

class AddItemStateNotifier extends StateNotifier<AddItemState> {
  final IItemsRepository _itemsRepository;
  AddItemStateNotifier(this._itemsRepository) : super(const AddItemState.loading());

  Future<void> addItem({required ItemModel item, required List<XFile> files}) async {
    state = const AddItemState.loading();

    final response = await _itemsRepository.addItem(item: item);

    response.pick(
      onError: (error) {
        state = AddItemState.failed(alert: error);
      },
      onData: (item) async {
        await updateItemPicture(files: files, itemId: item.id.toString());
        state = AddItemState.success(
          item: item,
          alert: const AlertModel(message: 'Successfully added item', type: AlertType.success),
        );
      },
    );
  }

  // TODO: PUT UPDATE ITEM HERE

  Future<void> updateItemPicture({required List<XFile> files, required String itemId}) async {
    await _itemsRepository.uplaodPicture(files: files, itemId: itemId, location: 'items');
  }
}
