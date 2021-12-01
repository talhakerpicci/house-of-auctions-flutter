import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:house_of_auctions/domain/interfaces/i_auth_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/modules/token_storage/token_storage.dart';
import 'package:injectable/injectable.dart';

part 'auth_provider.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthProvider extends ChangeNotifier {
  final IAuthRepository authRepository;
  AuthProvider({required this.authRepository});

  Future<void> login({required String email, required String password}) async {
    final response = await authRepository.login(
      email: email,
      password: password,
    );

    response.pick(
      onError: (error) {},
      onData: (token) {
        getIt<HiveTokenStorage>().write(token);
      },
    );
  }

  Future<void> register({required UserModel user, required String password}) async {
    final response = await authRepository.register(model: user, password: password);

    response.pick(
      onError: (error) {},
      onData: (token) {
        getIt<HiveTokenStorage>().write(token);
      },
    );
  }

  Future<void> logout() async {}
}
