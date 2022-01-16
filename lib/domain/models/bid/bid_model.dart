import 'package:freezed_annotation/freezed_annotation.dart';

part 'bid_model.freezed.dart';
part 'bid_model.g.dart';

@freezed
class BidModel with _$BidModel {
  const factory BidModel({
    required int id,
    required int itemId,
    required double bidAmount,
    required int bidderId,
    required String date,
  }) = _BidModel;

  factory BidModel.initial() => const BidModel(
        id: 0,
        itemId: 0,
        bidAmount: 0,
        bidderId: 0,
        date: '',
      );

  factory BidModel.fromJson(Map<String, dynamic> json) => _$BidModelFromJson(json);
}
