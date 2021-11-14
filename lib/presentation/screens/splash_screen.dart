import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatelessWidget {
  final PackageInfo appInfo = getIt.get<PackageInfo>();
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50),
        color: const Color(0xFF3B97A1),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            /* const Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.ac_unit,
              ),
            ), */
            Positioned(
              top: 100,
              child: Center(
                child: Text(
                  'House of Auctions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Image.asset('assets/images/splash_logo.png'),
            const Positioned(
              bottom: 130,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'v${appInfo.version}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
