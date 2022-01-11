part of 'items_provider.dart';

@freezed
class ItemsState with _$ItemsState {
  const factory ItemsState.loading() = ItemsLoading;
  const factory ItemsState.loaded({required List<ItemModel> items}) = ItemsLoaded;
  const factory ItemsState.failed({required AlertModel alert}) = ItemsFailed;
}
