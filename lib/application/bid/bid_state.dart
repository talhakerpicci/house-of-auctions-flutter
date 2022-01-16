part of 'bid_provider.dart';

@freezed
class BidsState with _$BidsState {
  const factory BidsState.loading() = BidsLoading;
  const factory BidsState.loaded({required List<BidModel> bids}) = BidsLoaded;
  const factory BidsState.failed({required AlertModel alert}) = BidsFailed;
}
