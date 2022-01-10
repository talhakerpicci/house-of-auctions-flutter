import 'package:data_channel/data_channel.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/core/token_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';

abstract class IUserRepository {
  Future<DC<AlertModel, UserModel>> getUserDetails();
  Future<DC<AlertModel, TokenModel>> updateUserInfo({required UserModel model});
  Future<DC<AlertModel, TokenModel>> updatePassword({required UserModel model});
}
