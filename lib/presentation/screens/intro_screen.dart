import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/domain/models/core/app_data_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/data_storage/data_storage.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> onDonePress() async {
    await getIt<HiveDataStorage>().write(
      const AppDataModel(skipIntro: true),
    );

    await context.router.replace(const WelcomeScreenRoute());
  }

  Widget renderDoneBtn() {
    return Text(
      'Get Started',
      textAlign: TextAlign.center,
      style: getTextTheme(context).subtitle1!.copyWith(color: AppColors.blue),
    );
  }

  Widget renderSkipBtn() {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        'Skip',
        style: getTextTheme(context).subtitle1!.copyWith(color: AppColors.blue),
      ),
    );
  }

  Widget renderNextBtn() {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        'Next',
        style: getTextTheme(context).subtitle1!.copyWith(color: AppColors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = getTextTheme(context);
    slides.add(
      Slide(
        widgetTitle: Text(
          'Welcome to House of Auctions',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: theme.headline1!.copyWith(color: AppColors.blue),
        ),
        description: 'House of Auctions is a mobile platform for users who want to trade their items in an auction',
        pathImage: 'assets/images/sliders/business.png',
        backgroundColor: Colors.white,
        styleDescription: theme.bodyText1!.copyWith(color: AppColors.darkGrey),
      ),
    );
    slides.add(
      Slide(
        widgetTitle: Text(
          'Just Bid More!',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: theme.headline1!.copyWith(color: AppColors.blue),
        ),
        description: 'Bid more to lose more!',
        pathImage: 'assets/images/sliders/payment.png',
        backgroundColor: Colors.white,
        styleDescription: theme.bodyText1!.copyWith(color: AppColors.darkGrey),
      ),
    );
    return IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
      hideStatusBar: false,
      renderDoneBtn: renderDoneBtn(),
      renderSkipBtn: renderSkipBtn(),
      renderNextBtn: renderNextBtn(),
    );
  }
}
