import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfoBase {
  Future<bool> get isConnected;
}

@lazySingleton
class NetworkInfo extends NetworkInfoBase {
  final Connectivity connectivity = Connectivity();

  @override
  Future<bool> get isConnected async => await connectivity.checkConnectivity() != ConnectivityResult.none;
}
