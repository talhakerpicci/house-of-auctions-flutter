import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:house_of_auctions/domain/interfaces/i_user_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:image_picker/image_picker.dart';

part 'user_info_provider.freezed.dart';
part 'user_info_state.dart';

final userInfoStateNotifierProvider = StateNotifierProvider<UserInfoStateNotifier, UserInfoState>(
  (ref) => UserInfoStateNotifier(getIt<IUserRepository>()),
);

class UserInfoStateNotifier extends StateNotifier<UserInfoState> {
  final IUserRepository _userRepository;
  UserInfoStateNotifier(this._userRepository) : super(const UserInfoState.initial());

  Future<void> updateUserInfo({required UserModel newUserData}) async {
    state = const UserInfoState.loading();

    final response = await _userRepository.updateUserInfo(model: newUserData);

    response.pick(
      onError: (error) {
        state = UserInfoState.failed(alert: error);
      },
      onData: (user) {
        state = UserInfoState.success(
          user: user,
          alert: const AlertModel(
            message: 'Successfully updated!',
            type: AlertType.success,
          ),
        );
      },
    );
  }

  // TODO: CARRY THIS OUT TO NEW PROVIDER OR SOMEHOW MANAGA TO KEEP USER STATE
  Future<void> updateUserPicture({required XFile file}) async {
    state = const UserInfoState.loading();

    await _userRepository.updateUserPicture(file: file);
  }

  Future<void> removeUserPicture({required String userId}) async {
    state = const UserInfoState.loading();

    await _userRepository.deleteUserPicture(userId);
  }
}
