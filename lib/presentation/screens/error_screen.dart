import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class ErrorScreen extends StatelessWidget {
  final Function()? onPressed;
  const ErrorScreen({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 120,
            height: 100,
            child: Icon(
              FontAwesomeIcons.exclamationTriangle,
              size: 100,
            ),
          ),
          const SpaceH20(),
          const Text(
            'An error occured.\n Please check your connection and try again.',
            textAlign: TextAlign.center,
          ),
          const SpaceH10(),
          CustomButton(
            onPressed: onPressed,
            height: 45,
            buttonPadding: const EdgeInsets.symmetric(horizontal: 30),
            color: AppColors.blue,
            child: Text(
              'Try Again',
              textAlign: TextAlign.center,
              style: getTextTheme(context).bodyText1!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
