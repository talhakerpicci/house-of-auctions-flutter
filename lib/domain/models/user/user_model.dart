import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String email,
    required String nameSurname,
    required String address,
    String? phoneNo,
    String? photoUrl,
  }) = _UserModel;

  factory UserModel.initial() => const UserModel(
        id: 0,
        email: '',
        nameSurname: '',
        address: '',
        phoneNo: '',
        photoUrl: '',
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
