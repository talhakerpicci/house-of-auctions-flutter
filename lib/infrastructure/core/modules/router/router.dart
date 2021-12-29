import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:house_of_auctions/app_handler.dart';
import 'package:house_of_auctions/app_navigator.dart';
import 'package:house_of_auctions/presentation/screens/authentication/login_screen.dart';
import 'package:house_of_auctions/presentation/screens/authentication/sign_up_screen.dart';
import 'package:house_of_auctions/presentation/screens/authentication/welcome_screen.dart';
import 'package:house_of_auctions/presentation/screens/chat/chat_detail_screen.dart';
import 'package:house_of_auctions/presentation/screens/intro_screen.dart';
import 'package:house_of_auctions/presentation/screens/items/add_item_screen.dart';
import 'package:house_of_auctions/presentation/screens/items/feed_item_detail_screen.dart';
import 'package:house_of_auctions/presentation/screens/items/search_item_screen.dart';
import 'package:house_of_auctions/presentation/screens/splash_screen.dart';
import 'package:house_of_auctions/presentation/screens/user/update_email_screen.dart';
import 'package:house_of_auctions/presentation/screens/user/update_name_screen.dart';
import 'package:house_of_auctions/presentation/screens/user/update_password_screen.dart';
import 'package:house_of_auctions/presentation/screens/user/user_profile_screen.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(
      page: AppHandler,
      initial: true,
      children: [
        MaterialRoute(page: SplashScreen),
        MaterialRoute(page: IntroScreen),
        MaterialRoute(page: SignUpScreen),
        MaterialRoute(page: WelcomeScreen),
        MaterialRoute(page: LoginScreen),
        MaterialRoute(page: AppNavigator),
        MaterialRoute(page: AddItemScreen),
        MaterialRoute(page: UserProfileScreen),
        MaterialRoute(page: ChatDetailScreen),
        MaterialRoute(page: FeedItemDetailScreen),
        MaterialRoute(page: UpdateNameScreen),
        MaterialRoute(page: UpdateEmailScreen),
        MaterialRoute(page: UpdatePasswordScreen),
        MaterialRoute(page: SearchItemScreen),
      ],
    ),
  ],
)
class $AppRouter {}
