import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:house_of_auctions/app_navigator.dart';
import 'package:house_of_auctions/presentation/screens/authentication/login_screen.dart';
import 'package:house_of_auctions/presentation/screens/authentication/sign_up_screen.dart';
import 'package:house_of_auctions/presentation/screens/authentication/welcome_screen.dart';
import 'package:house_of_auctions/presentation/screens/intro_screen.dart';
import 'package:house_of_auctions/presentation/screens/items/add_item_screen.dart';
import 'package:house_of_auctions/presentation/screens/splash_screen.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: IntroScreen),
    MaterialRoute(page: SignUpScreen),
    MaterialRoute(page: WelcomeScreen),
    MaterialRoute(page: LoginScreen),
    MaterialRoute(page: AppNavigator),
    MaterialRoute(page: AddItemScreen),
  ],
)
class $AppRouter {}
