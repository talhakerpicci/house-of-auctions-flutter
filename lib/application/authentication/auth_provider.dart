import 'dart:async';
import 'package:house_of_auctions/application/base/base_provider.dart';
import 'package:house_of_auctions/domain/interfaces/i_auth_repository.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/modules/token_storage/token_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthProvider extends BaseProvider {
  final IAuthRepository authRepository;
  AuthProvider({required this.authRepository});

  Future<void> login({required String email, required String password}) async {
    setState(ViewState.loading);
    final response = await authRepository.login(
      email: email,
      password: password,
    );

    response.pick(
      onError: (error) {
        setState(ViewState.error);
      },
      onData: (token) {
        getIt<HiveTokenStorage>().write(token);
        setState(ViewState.ready);
      },
    );
  }

  Future<void> register({required UserModel user, required String password}) async {
    setState(ViewState.loading);
    final response = await authRepository.register(model: user, password: password);

    response.pick(
      onError: (error) {
        setState(ViewState.error);
      },
      onData: (token) {
        getIt<HiveTokenStorage>().write(token);
        setState(ViewState.ready);
      },
    );
  }

  Future<void> logout() async {}
}
