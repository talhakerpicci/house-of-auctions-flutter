part of 'user_info_provider.dart';

@freezed
class UserInfoState with _$UserInfoState {
  const factory UserInfoState.initial() = UserInfoInitial;
  const factory UserInfoState.loading() = UserInfoLoading;
  const factory UserInfoState.success({required UserModel user, required AlertModel alert}) = UserInfoSuccess;
  const factory UserInfoState.failed({required AlertModel alert}) = UserInfoFailed;
}
