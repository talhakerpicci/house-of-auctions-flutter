import 'package:data_channel/data_channel.dart';
import 'package:house_of_auctions/domain/models/bid/bid_model.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';

abstract class IBidRepository {
  Future<DC<AlertModel, List<BidModel>>> getUserBids();
  Future<DC<AlertModel, BidModel>> createBid({required BidModel bid});
}
