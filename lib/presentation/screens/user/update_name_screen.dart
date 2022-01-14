import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/user/user_provider.dart';
import 'package:house_of_auctions/application/user_info/user_info_provider.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/custom_loading_overlay_widget.dart';
import 'package:house_of_auctions/presentation/widgets/core/text_field.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class UpdateNameScreen extends ConsumerStatefulWidget {
  final String nameSurname;

  const UpdateNameScreen({Key? key, required this.nameSurname}) : super(key: key);
  @override
  _UpdateNameScreenState createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends ConsumerState<UpdateNameScreen> {
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;
  String _newNameSurname = '';

  final TextEditingController _nameSurnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newNameSurname = widget.nameSurname;
    _nameSurnameController.value = TextEditingValue(text: _newNameSurname, selection: _nameSurnameController.selection);
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
      onPressed: () async {
        final state = ref.read(userStateNotifierProvider);
        final user = (state as UserLoaded).user;
        setState(() {
          _isLoading = true;
        });
        await ref.read(userInfoStateNotifierProvider.notifier).updateUserInfo(
              newUserData: user.copyWith(
                nameSurname: _newNameSurname,
              ),
            );
        setState(() {
          _isLoading = false;
        });
      },
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
        controller: _nameSurnameController,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: 'Name Surname',
        prefixIcon: const Icon(Icons.email),
        onChanged: (String value) {
          _newNameSurname = value;
        },
        onFieldSubmitted: (_) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email cant be empty';
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
      body: CustomLoadingOverlayWidget(
        isLoading: _isLoading,
        opacity: 0.7,
        child: GestureDetector(
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
      ),
    );
  }
}
