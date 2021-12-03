import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/user_avatar.dart';

class SearchAppbarWidget extends StatelessWidget with PreferredSizeWidget {
  const SearchAppbarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                await context.router.push(const UserProfileScreenRoute());
              },
              child: const UserAvatar(/* user: userModel */),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                borderRadius: 12,
                color: Colors.white,
                fullWidth: false,
                // TODO: NAVIGATTE TO SEARCH SCREEN
                onPressed: () {},
                child: Text(
                  'Search items',
                  style: getTextTheme(context).bodyText2!.copyWith(
                        color: AppColors.darkGrey.withOpacity(0.4),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () {},
              child: const Text('Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
