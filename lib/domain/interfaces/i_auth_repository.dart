import 'package:data_channel/data_channel.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/core/token_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';

abstract class IAuthRepository {
  Future<DC<AlertModel, TokenModel>> login({required String email, required String password});
  Future<DC<AlertModel, TokenModel>> register({required UserModel model, required String password});
  Future<DC<AlertModel, void>> logout(TokenModel tokens);
}
