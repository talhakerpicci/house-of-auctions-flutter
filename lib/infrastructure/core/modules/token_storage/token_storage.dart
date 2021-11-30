import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:house_of_auctions/domain/models/core/token_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@preResolve
class HiveTokenStorage {
  final Box<dynamic> _hiveBox;

  HiveTokenStorage(this._hiveBox);

  @factoryMethod
  static Future<HiveTokenStorage> create() async {
    final box = await Hive.openBox('tokens');

    return HiveTokenStorage(box);
  }

  TokenModel? read() {
    final _accessToken = _hiveBox.get('accessToken', defaultValue: '') as String;
    final _refreshToken = _hiveBox.get('refreshToken', defaultValue: '') as String;

    if (_accessToken.isNotEmpty) {
      return TokenModel(
        accessToken: _accessToken,
        refreshToken: _refreshToken,
      );
    }

    return null;
  }

  Future write(TokenModel token) async {
    await _hiveBox.putAll({
      'accessToken': token.accessToken,
      'refreshToken': token.refreshToken,
    });
  }

  Future delete() async {
    await _hiveBox.putAll({
      'accessToken': '',
      'refreshToken': '',
    });
  }
}
