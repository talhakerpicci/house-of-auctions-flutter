import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget _logo() {
    return Image.asset(
      'assets/images/splash_logo.png',
      width: getSize(context).width,
      height: getSize(context).height * 0.25,
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        context.router.push(const LoginScreenRoute());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.white.withAlpha(100),
              offset: const Offset(2, 4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
          color: Colors.white,
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.darkGrey,
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        context.router.push(const SignUpScreenRoute());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return const Text(
      'House of Auctions',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  Widget _infoButton() {
    return GestureDetector(
      onTap: () {},
      child: const Text(
        'FAQs',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[
            AppColors.green,
            AppColors.blue,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: size.width,
          height: size.height,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: size.height * 0.1,
              ),
              SizedBox(
                height: size.height * 0.5,
                child: Column(
                  children: [
                    _logo(),
                    const SpaceH30(),
                    _title(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    _loginButton(),
                    const SpaceH20(),
                    _signUpButton(),
                    const SpaceH20(),
                    _infoButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
