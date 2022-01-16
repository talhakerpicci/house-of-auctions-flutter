import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:house_of_auctions/domain/interfaces/i_bid_repository.dart';
import 'package:house_of_auctions/domain/models/bid/bid_model.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';

part 'bid_provider.freezed.dart';
part 'bid_state.dart';

final bidStateNotifierProvider = StateNotifierProvider<BidStateNotifier, BidsState>(
  (ref) => BidStateNotifier(getIt<IBidRepository>()),
);

class BidStateNotifier extends StateNotifier<BidsState> {
  final IBidRepository _bidRepository;
  BidStateNotifier(this._bidRepository) : super(const BidsState.loading());

  Future<void> getUserBids() async {
    state = const BidsState.loading();

    final response = await _bidRepository.getUserBids();

    response.pick(
      onError: (error) {
        state = BidsState.failed(alert: error);
      },
      onData: (bids) {
        state = BidsState.loaded(bids: bids);
      },
    );
  }

  Future<void> createBid({required BidModel bid}) async {
    state = const BidsState.loading();
    await _bidRepository.createBid(bid: bid);
    final response = await _bidRepository.getUserBids();

    response.pick(
      onError: (error) {
        state = BidsState.failed(alert: error);
      },
      onData: (bids) {
        state = BidsState.loaded(bids: bids);
      },
    );
  }
}
