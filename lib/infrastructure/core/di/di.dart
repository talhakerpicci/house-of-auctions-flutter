import 'package:get_it/get_it.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.config.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future configureDependencyInjection(String env) async => $initGetIt(getIt, environment: env);
