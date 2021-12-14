import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/infrastructure/core/constants/app_theme.dart';
import 'package:house_of_auctions/infrastructure/core/constants/di.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/modules/data_storage/data_storage.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';

class AppMain extends StatelessWidget {
  AppMain({Key? key}) : super(key: key);

  final _appRouter = AppRouter();
  final _i18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      basePath: 'assets/locales',
      forcedLocale: const Locale('tr'),
      decodeStrategies: [
        JsonDecodeStrategy(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final result = getIt<HiveDataStorage>().read();
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: env.debugShowCheckedModeBanner,
        debugShowMaterialGrid: env.debugShowMaterialGrid,
        routerDelegate: AutoRouterDelegate(
          _appRouter,
          initialRoutes: [
            if (!result.skipIntro) const IntroScreenRoute(),
          ],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        localizationsDelegates: [
          _i18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: AppTheme.defaultTheme,
      ),
    );
  }
}
