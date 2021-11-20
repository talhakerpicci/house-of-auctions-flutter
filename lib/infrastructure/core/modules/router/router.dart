import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:house_of_auctions/presentation/screens/authentication/sign_up_screen.dart';
import 'package:house_of_auctions/presentation/screens/intro_screen.dart';
import 'package:house_of_auctions/presentation/screens/splash_screen.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: IntroScreen),
    MaterialRoute(page: SignUpScreen),
  ],
)
class $AppRouter {}
