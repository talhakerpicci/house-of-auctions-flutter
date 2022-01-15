part of 'add_item_provider.dart';

@freezed
class AddItemState with _$AddItemState {
  const factory AddItemState.loading() = ItemLoading;
  const factory AddItemState.success({required ItemModel item, required AlertModel alert}) = ItemSuccess;
  const factory AddItemState.failed({required AlertModel alert}) = ItemFailed;
}
