import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    required int id,
    required String name,
    required String description,
    required double initialPrice,
    required String startDate,
    required String endDate,
    required double currentBid,
    required int userId,
    required int buyerId,
  }) = _ItemModel;

  factory ItemModel.initial() => const ItemModel(
        id: 0,
        name: '',
        description: '',
        initialPrice: 0,
        startDate: '',
        endDate: '',
        currentBid: 0,
        userId: 0,
        buyerId: 0,
      );

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
}
