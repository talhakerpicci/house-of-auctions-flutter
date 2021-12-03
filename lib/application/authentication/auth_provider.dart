import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:house_of_auctions/domain/interfaces/i_auth_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/modules/token_storage/token_storage.dart';
import 'package:injectable/injectable.dart';

part 'auth_provider.freezed.dart';
part 'auth_state.dart';

final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(getIt<IAuthRepository>()),
);

@lazySingleton
class AuthStateNotifier extends StateNotifier<AuthState> {
  final IAuthRepository _authRepository;
  AuthStateNotifier(this._authRepository) : super(const AuthState.loading()) {
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      final token = getIt<HiveTokenStorage>().read();
      if (token != null) {
        state = const AuthState.authenticated();
      } else {
        state = const AuthState.unauthenticated();
      }
    });
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthState.loading();

    final response = await _authRepository.login(
      email: email,
      password: password,
    );

    response.pick(
      onError: (error) {
        state = AuthState.failed(alert: AlertModel(message: error.message, type: AlertType.error));
      },
      onData: (token) {
        getIt<HiveTokenStorage>().write(token);
        state = const AuthState.authenticated();
      },
    );
  }

  Future<void> register({required UserModel user, required String password}) async {
    state = const AuthState.loading();

    final response = await _authRepository.register(model: user, password: password);

    response.pick(
      onError: (error) {
        state = AuthState.failed(alert: AlertModel(message: error.message, type: AlertType.error));
      },
      onData: (token) {
        getIt<HiveTokenStorage>().write(token);
        state = const AuthState.authenticated();
      },
    );
  }

  Future<void> logout() async {}
}
