import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/text_field.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _showIndicator = false;

  String _newNameSurname = '';

  final FocusNode _nameSurnameFocusNode = FocusNode();

  final TextEditingController _nameSurnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        if (!_isLoading) {
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: const Icon(Icons.keyboard_arrow_left, color: Colors.white),
      ),
    );
  }

  Widget submitButton() {
    return CustomButton(
      buttonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      color: AppColors.blue,
      onPressed: () {},
      child: Center(
        child: Text(
          'Update',
          style: getTextTheme(context).headline6!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  Widget nameSurnameWidget() {
    return Form(
      key: _form,
      child: CustomTextField(
        width: getSize(context).width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: 'Password',
        prefixIcon: const Icon(Icons.email),
        onChanged: (String value) {},
        onFieldSubmitted: (_) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password cant be empty';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: unFocus,
        child: Stack(
          children: [
            SizedBox(
              height: height,
              child: Column(
                children: <Widget>[
                  Container(
                    width: width,
                    height: height / 3,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.blue,
                          AppColors.blue,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Align(
                            child: Text(
                              'House of Auctions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 32, right: 32),
                            child: Text(
                              'Update Profile',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView(
                        children: <Widget>[
                          const SpaceH60(),
                          nameSurnameWidget(),
                          const SpaceH10(),
                          submitButton(),
                          const SpaceH20(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 30,
              left: 0,
              child: _backButton(),
            ),
          ],
        ),
      ),
    );
  }
}
