import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/text_field.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: false,
        child: GestureDetector(
          onTap: unFocus,
          child: ListView(
            children: <Widget>[
              const SpaceH40(),
              SizedBox(
                height: 150,
                child: SvgPicture.asset(
                  'assets/images/auth/secure_login.svg',
                ),
              ),
              const SpaceH30(),
              Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: getTextTheme(context).headline1,
              ),
              const SpaceH40(),
              CustomTextField(
                width: getSize(context).width,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                onChanged: (String value) {},
              ),
              const SpaceH10(),
              CustomTextField(
                width: getSize(context).width,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Password',
                prefixIcon: const Icon(Icons.vpn_key),
                onChanged: (String value) {},
              ),
              const SpaceH10(),
              CustomTextField(
                width: getSize(context).width,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Password Again',
                prefixIcon: const Icon(Icons.vpn_key),
                onChanged: (String value) {},
              ),
              const SpaceH16(),
              CustomButton(
                color: AppColors.blue,
                fullWidth: false,
                buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
                onPressed: () {
                  context.router.replaceAll([const AppNavigatorRoute()]);
                },
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: getTextTheme(context).subtitle1,
                  ),
                ),
              ),
              const SpaceH10(),
            ],
          ),
        ),
      ),
    );
  }
}
