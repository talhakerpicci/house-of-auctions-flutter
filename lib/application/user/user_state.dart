part of 'user_provider.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.loading() = UserLoading;
  const factory UserState.loaded({required UserModel user}) = UserLoaded;
  const factory UserState.failed({required AlertModel alert}) = UserFailed;
}
