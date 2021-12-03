import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:house_of_auctions/app_main.dart';
import 'package:house_of_auctions/infrastructure/core/constants/di.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:injectable/injectable.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent)); */

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  await Hive.initFlutter();

  await configureDependencyInjection(Environment.dev);

  Isolate.current.addErrorListener(
    RawReceivePort((pair) async {
      final errorAndStacktrace = pair as List;

      logger.error(
        'An error was captured by main.Isolate.current.addErrorListener',
        error: errorAndStacktrace.first,
      );
    }).sendPort,
  );

  runApp(AppMain());
}
