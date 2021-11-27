import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/app_theme.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';

enum AvatarSize { small, medium, large, xLarge }

class UserAvatar extends StatefulWidget {
  /* final UserModel user; */
  final AvatarSize size;

  const UserAvatar({
    Key? key,
    /* required this.user, */
    this.size = AvatarSize.large,
  }) : super(key: key);

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  late final Color _backgroundColor;

  bool get isInitial => false; /* widget.user == UserModel.initial(); */

  @override
  void initState() {
    _backgroundColor = AppColors.getRandomColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = 'Talha'; /* widget.user.firstName; */
    final lastName = 'Kerpicci'; /* widget.user.lastName; */

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.lightGrey,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGrey.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: CircleAvatar(
        backgroundColor: _backgroundColor,
        radius: getSize(),
        child: isInitial
            ? Icon(
                Icons.person,
                color: AppColors.lightGrey.withOpacity(0.8),
              )
            : Text(
                '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}',
                style: AppTheme.defaultTextStyle.copyWith(
                  fontSize: getFontSize(),
                  color: AppColors.lightGrey.withOpacity(0.8),
                ),
              ),
      ),
    );
  }

  double getSize() {
    switch (widget.size) {
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
    switch (widget.size) {
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
