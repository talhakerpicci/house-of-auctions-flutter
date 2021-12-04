part of 'auth_provider.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated({AlertModel? alert}) = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.failed({required AlertModel alert}) = AuthFailed;
}
