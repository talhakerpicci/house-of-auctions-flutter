import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:house_of_auctions/domain/interfaces/i_user_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';

part 'user_provider.freezed.dart';
part 'user_state.dart';

final userStateNotifierProvider = StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(getIt<IUserRepository>()),
);

class UserStateNotifier extends StateNotifier<UserState> {
  final IUserRepository _userRepository;
  UserStateNotifier(this._userRepository) : super(const UserState.loading());

  Future<void> getUserDetails() async {
    state = const UserState.loading();

    final response = await _userRepository.getUserDetails();

    response.pick(
      onError: (error) {
        state = UserState.failed(alert: error);
      },
      onData: (user) {
        state = UserState.loaded(user: user);
      },
    );
  }

  Future<void> updateUserInfo({required UserModel newUserData}) async {
    state = UserState.loaded(user: newUserData);
  }
}
