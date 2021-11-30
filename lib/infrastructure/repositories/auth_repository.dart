import 'package:data_channel/data_channel.dart';
import 'package:house_of_auctions/domain/interfaces/i_auth_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/core/token_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/modules/api_client/api_client.dart';
import 'package:house_of_auctions/infrastructure/core/modules/token_storage/token_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  @override
  Future<DC<AlertModel, TokenModel>> login({required String email, required String password}) async {
    try {
      final result = await _apiClient.post('/login', {
        'email': email,
        'password': password,
      });
      final tokenModel = TokenModel(
        accessToken: (result.data as Map)['access_token'],
        refreshToken: '',
      );

      return DC.data(tokenModel);
    } catch (e) {
      final _alert = AlertModel(message: e.toString(), type: AlertType.error);

      return DC.error(_alert);
    }
  }

  @override
  Future<DC<AlertModel, TokenModel>> register({required UserModel model, required String password}) async {
    try {
      final data = model.toJson();
      data['password'] = password;
      final result = await _apiClient.post('/register', data);
      final tokenModel = TokenModel(
        accessToken: (result.data as Map)['access_token'],
        refreshToken: '',
      );

      return DC.data(tokenModel);
    } catch (e) {
      final _alert = AlertModel(message: e.toString(), type: AlertType.error);

      return DC.error(_alert);
    }
  }

  @override
  Future<DC<AlertModel, void>> logout(TokenModel tokens) async {
    try {
      await getIt<HiveTokenStorage>().delete();
      return DC.data(null);
    } on Exception catch (e) {
      final _alert = AlertModel(message: e.toString(), type: AlertType.error);
      return DC.error(_alert);
    }
  }
}
