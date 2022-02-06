import 'package:data_channel/data_channel.dart';
import 'package:dio/dio.dart';
import 'package:house_of_auctions/domain/interfaces/i_user_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/modules/api_client/api_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  @override
  Future<DC<AlertModel, UserModel>> getUserDetails() async {
    try {
      final response = await _apiClient.get('/user');
      final user = UserModel.fromJson(response.data);
      return DC.data(user);
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
  Future<DC<AlertModel, UserModel>> updateUserInfo({required UserModel model}) async {
    try {
      final response = await _apiClient.put('/user/${model.id}', model.toJson());
      final user = UserModel.fromJson(response.data);
      return DC.data(user);
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
  Future<DC<AlertModel, bool>> updatePassword({required String newPassword}) {
    throw UnimplementedError();
  }

  @override
  Future<DC<AlertModel, bool>> updateUserPicture({required XFile file}) async {
    try {
      final formData = FormData.fromMap({
        'file_0': await MultipartFile.fromFile(file.path, filename: file.name),
        'location': 'users',
      });
      /* formData.files.addAll([
        MapEntry("assignment", await MultipartFile.fromFile(file)),
      ]); */

      await _apiClient.post(
        '/upload-image',
        formData,
      );

      return DC.data(null);
    } catch (e) {
      Object errorMessage;

      if (e is DioError && e.response != null) {
        errorMessage = e.response!.data;
      } else {
        errorMessage = e.toString();
      }

      final _alert = AlertModel(message: errorMessage.toString(), type: AlertType.error);

      return DC.error(_alert);
    }
  }

  @override
  Future<DC<AlertModel, bool>> deleteUserPicture(String userId) async {
    try {
      await _apiClient.delete(
        '/delete-user-image/$userId',
      );

      return DC.data(null);
    } catch (e) {
      Object errorMessage;

      if (e is DioError && e.response != null) {
        errorMessage = e.response!.data;
      } else {
        errorMessage = e.toString();
      }

      final _alert = AlertModel(message: errorMessage.toString(), type: AlertType.error);

      return DC.error(_alert);
    }
  }
}
