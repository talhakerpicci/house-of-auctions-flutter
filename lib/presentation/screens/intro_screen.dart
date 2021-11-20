import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/domain/models/core/app_data_model.dart';
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
  final _appRouter = AppRouter();
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> onDonePress() async {
    await getIt<HiveDataStorage>().write(
      const AppDataModel(showIntro: false),
    );

    await _appRouter.replace(
      const SignUpScreenRoute(),
    );
  }

  Widget renderDoneBtn() {
    return const Text(
      'Get Started',
      /* style: const TextStyle(
        color: AppColors.nord1,
      ), */
      textAlign: TextAlign.center,
    );
  }

  Widget renderSkipBtn() {
    return const FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        'Skip',
        /* style: const TextStyle(
          color: AppColors.nord1,
        ), */
      ),
    );
  }

  Widget renderNextBtn() {
    return const FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        'Next',
        /* style: const TextStyle(
          color: AppColors.nord1,
        ), */
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
          style: theme.headline2,
          textAlign: TextAlign.center,
        ),
        description: 'House of Auctions is a an app where rich ppl get to get everything',
        pathImage: 'assets/images/sliders/business.png',
        backgroundColor: Colors.white,
        /* styleTitle: theme.headline2!.copyWith(color: AppColors.yellow),
        styleDescription: const TextStyle(
          color: AppColors.yellow,
          fontSize: 14,
          height: 1.4,
        ), */
      ),
    );
    slides.add(
      Slide(
        widgetTitle: Text(
          'Just Bid More!',
          maxLines: 2,
          style: theme.headline2,
          textAlign: TextAlign.center,
        ),
        description: 'Bid more to lose more!',
        pathImage: 'assets/images/sliders/payment.png',
        backgroundColor: Colors.white,
        /* styleTitle: theme.headline2!.copyWith(color: AppColors.yellow),
        styleDescription: const TextStyle(
          color: AppColors.yellow,
          fontSize: 14,
          height: 1.4,
        ), */
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
