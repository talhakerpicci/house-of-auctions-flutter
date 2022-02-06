import 'package:data_channel/data_channel.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class IUserRepository {
  Future<DC<AlertModel, UserModel>> getUserDetails();
  Future<DC<AlertModel, UserModel>> updateUserInfo({required UserModel model});
  Future<DC<AlertModel, bool>> updateUserPicture({required XFile file});
  Future<DC<AlertModel, bool>> deleteUserPicture(String userId);
  Future<DC<AlertModel, bool>> updatePassword({required String newPassword});
}
