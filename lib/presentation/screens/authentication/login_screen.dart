import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_of_auctions/application/authentication/auth_provider.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/text_field.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String email = '';
  String password = '';

  final _form = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.value = TextEditingValue(text: email, selection: emailController.selection);
    passwordController.value = TextEditingValue(text: password, selection: passwordController.selection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: unFocus,
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              const SpaceH40(),
              SizedBox(
                height: 150,
                child: SvgPicture.asset(
                  'assets/images/auth/login.svg',
                ),
              ),
              const SpaceH30(),
              Text(
                'Login',
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
                focusNode: emailFocusNode,
                controller: emailController,
                onChanged: (String value) {
                  email = value;
                },
                onFieldSubmitted: (_) {
                  requestFocus(context, passwordFocusNode);
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
                focusNode: passwordFocusNode,
                controller: passwordController,
                obscureText: true,
                prefixIcon: const Icon(Icons.vpn_key),
                onChanged: (String value) {
                  password = value;
                },
                onFieldSubmitted: (_) {
                  unFocus();
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
                  await ref.read(authStateNotifierProvider.notifier).login(
                        email: email,
                        password: password,
                      );
                },
                child: Center(
                  child: Text(
                    'Login',
                    style: getTextTheme(context).subtitle1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
