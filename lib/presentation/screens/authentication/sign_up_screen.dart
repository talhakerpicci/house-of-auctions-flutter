import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_of_auctions/application/authentication/auth_provider.dart';
import 'package:house_of_auctions/application/base/base_provider.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/text_field.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserModel user = UserModel.initial();

  String password = '';
  String passwordAgain = '';

  final _form = GlobalKey<FormState>();

  final FocusNode nameSurnameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode passwordAgainFocusNode = FocusNode();

  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameSurnameController.value = TextEditingValue(text: user.nameSurname, selection: nameSurnameController.selection);
    emailController.value = TextEditingValue(text: user.email, selection: emailController.selection);
    passwordController.value = TextEditingValue(text: password, selection: passwordController.selection);
    passwordAgainController.value = TextEditingValue(text: passwordAgain, selection: passwordAgainController.selection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(
        builder: (_, value, __) => LoadingOverlay(
          isLoading: value.state == ViewState.loading,
          child: GestureDetector(
            onTap: unFocus,
            child: Form(
              key: _form,
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
                    hintText: 'Name Surname',
                    controller: nameSurnameController,
                    focusNode: nameSurnameFocusNode,
                    onFieldSubmitted: (p0) {
                      requestFocus(context, emailFocusNode);
                    },
                    prefixIcon: const Icon(Icons.person),
                    onChanged: (String value) {
                      user = user.copyWith(
                        nameSurname: value,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name surname cant be empty';
                      }
                      return null;
                    },
                  ),
                  const SpaceH10(),
                  CustomTextField(
                    width: getSize(context).width,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Email',
                    controller: emailController,
                    focusNode: emailFocusNode,
                    onFieldSubmitted: (p0) {
                      requestFocus(context, passwordFocusNode);
                    },
                    prefixIcon: const Icon(Icons.email),
                    onChanged: (String value) {
                      user = user.copyWith(
                        email: value,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cant be empty';
                      }
                      return null;
                    },
                  ),
                  const SpaceH10(),
                  CustomTextField(
                    width: getSize(context).width,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Password',
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    onFieldSubmitted: (p0) {
                      requestFocus(context, passwordAgainFocusNode);
                    },
                    obscureText: true,
                    prefixIcon: const Icon(Icons.vpn_key),
                    onChanged: (String value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cant be empty';
                      }
                      return null;
                    },
                  ),
                  const SpaceH10(),
                  CustomTextField(
                    width: getSize(context).width,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Password Again',
                    controller: passwordAgainController,
                    focusNode: passwordAgainFocusNode,
                    onFieldSubmitted: (p0) {
                      unFocus();
                    },
                    obscureText: true,
                    prefixIcon: const Icon(Icons.vpn_key),
                    onChanged: (String value) {
                      passwordAgain = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cant be empty';
                      }
                      return null;
                    },
                  ),
                  const SpaceH16(),
                  CustomButton(
                    color: AppColors.blue,
                    fullWidth: false,
                    buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () async {
                      final isValid = _form.currentState!.validate();
                      if (!isValid) {
                        return;
                      }

                      /* await getIt<AuthProvider>().register(user: user, password: password); */
                      var data = user.toJson();
                      data['password'] = password;
                      Dio dio = Dio();
                      await dio.post('http://192.168.0.24:59238/register', data: data,);

                      /* context.router.replaceAll([const AppNavigatorRoute()]); */
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
        ),
      ),
    );
  }
}
