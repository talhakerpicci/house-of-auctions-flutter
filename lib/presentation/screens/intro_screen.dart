import 'package:flutter/material.dart';
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

    slides.add(
      Slide(
        widgetTitle: const Text(
          'Welcome',
          maxLines: 2,
          /* style: const TextStyle(
            color: AppColors.nord1,
            fontSize: 22,
          ), */
          textAlign: TextAlign.center,
        ),
        description: 'Description',
        /* pathImage: '', */
        /* backgroundColor: Colors.white,
        styleTitle: const TextStyle(
          color: AppColors.nord1,
          fontSize: 22,
        ),
        styleDescription: const TextStyle(
          color: AppColors.nord1,
          fontSize: 14,
          height: 1.4,
        ), */
      ),
    );
    slides.add(
      Slide(
        widgetTitle: const Text(
          'Easily Bid',
          maxLines: 2,
          /* style: const TextStyle(
            color: AppColors.nord1,
            fontSize: 22,
          ), */
          textAlign: TextAlign.center,
        ),
        description: 'Win ez',
        /* pathImage: '', */
        backgroundColor: Colors.white,
        /* styleTitle: const TextStyle(
          color: AppColors.nord1,
          fontSize: 22,
        ),
        styleDescription: const TextStyle(
          color: AppColors.nord1,
          fontSize: 14,
          height: 1.4,
        ), */
      ),
    );
  }

  Future<void> onDonePress() async {
    /* var prefs = await SharedPreferences.getInstance();
    prefs.setBool('showSliders', false);

    Get.offAll(() => WelcomeScreen()); */
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
