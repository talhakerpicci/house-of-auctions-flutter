import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/user/user_provider.dart';
import 'package:house_of_auctions/infrastructure/core/constants/app_theme.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/bar/bar_helper.dart';

enum AvatarSize { small, medium, large, xLarge }

class UserAvatar extends ConsumerWidget {
  final AvatarSize size;

  const UserAvatar({
    Key? key,
    this.size = AvatarSize.large,
  }) : super(key: key);

  Widget buildAvatar(UserState state, BuildContext context) {
    if (state is UserLoading) {
      return const CircularProgressIndicator();
    } else if (state is UserLoaded) {
      final nameSurname = state.user.nameSurname.split(' ');
      final firstName = nameSurname[0][0].toUpperCase();
      final lastName = nameSurname.length > 1 ? nameSurname[1][0].toUpperCase() : '';
      return Text(
        '$firstName$lastName',
        style: AppTheme.defaultTextStyle.copyWith(
          fontSize: getFontSize(),
          color: AppColors.lightGrey.withOpacity(0.8),
        ),
      );
    } else {
      BarHelper.showAlert(
        AutoRouter.of(context).navigatorKey.currentContext!,
        alert: (state as UserFailed).alert,
        showAboveBottomBar: true,
      );
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = AppColors.getRandomColor();
    return Consumer(builder: (context, ref, _) {
      final state = ref.watch(userStateNotifierProvider);
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGrey,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGrey.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(24),
        ),
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: getSize(),
          child: buildAvatar(state, context),
        ),
      );
    });
  }

  double getSize() {
    switch (size) {
      case AvatarSize.small:
        return 8;
      case AvatarSize.medium:
        return 12;
      case AvatarSize.large:
        return 18;
      case AvatarSize.xLarge:
        return 48;
    }
  }

  double getFontSize() {
    switch (size) {
      case AvatarSize.small:
        return 7.2;
      case AvatarSize.medium:
        return 10;
      case AvatarSize.large:
        return 14;
      case AvatarSize.xLarge:
        return 24;
    }
  }
}
