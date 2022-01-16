import 'package:data_channel/data_channel.dart';
import 'package:dio/dio.dart';
import 'package:house_of_auctions/domain/interfaces/i_bid_repository.dart';
import 'package:house_of_auctions/domain/models/bid/bid_model.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/infrastructure/core/modules/api_client/api_client.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IBidRepository)
class BidRepository implements IBidRepository {
  final ApiClient _apiClient;

  BidRepository(this._apiClient);

  @override
  Future<DC<AlertModel, List<BidModel>>> getUserBids() async {
    try {
      final response = await _apiClient.get('/get-bids');
      final list = response.data as Map;
      final items = (list['bids'] as List).map((json) => BidModel.fromJson(json)).toList();

      return DC.data(items);
    } catch (e) {
      String errorMessage;

      if (e is DioError && e.response != null) {
        errorMessage = (e.response!.data as Map)['message'];
      } else {
        errorMessage = e.toString();
      }

      final _alert = AlertModel(message: errorMessage, type: AlertType.error);

      return DC.error(_alert);
    }
  }

  @override
  Future<DC<AlertModel, BidModel>> createBid({required BidModel bid}) async {
    try {
      final response = await _apiClient.post('/bid', bid.toJson());
      final model = BidModel.fromJson(response.data);

      return DC.data(model);
    } catch (e) {
      String errorMessage;

      if (e is DioError) {
        errorMessage = (e.response!.data as Map)['message'];
      } else {
        errorMessage = e.toString();
      }

      final _alert = AlertModel(message: errorMessage, type: AlertType.error);

      return DC.error(_alert);
    }
  }
}
