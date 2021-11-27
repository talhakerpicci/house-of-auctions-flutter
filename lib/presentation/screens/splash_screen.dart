import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatelessWidget {
  final PackageInfo appInfo = getIt.get<PackageInfo>();
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF14bf96),
        child: Column(
          /* fit: StackFit.expand,
          alignment: Alignment.center, */
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpaceH40(),
            Text(
              'House of Auctions',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white),
            ),
            const SpaceH40(),
            Image.asset('assets/images/splash_logo.png'),
            const SpaceH40(),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SpaceH30(),
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
