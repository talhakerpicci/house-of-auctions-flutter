import 'package:fresh_dio/fresh_dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:house_of_auctions/domain/models/core/token_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenStorage)
@preResolve
class HiveTokenStorage extends TokenStorage<TokenModel> {
  final Box<dynamic> _hiveBox;

  HiveTokenStorage(this._hiveBox);

  @factoryMethod
  static Future<HiveTokenStorage> create() async {
    // inits hive storage and makes the token box ready
    await Hive.initFlutter();
    final box = await Hive.openBox('tokens');

    return HiveTokenStorage(box);
  }

  @override
  Future<TokenModel?> read() async {
    final _accessToken = _hiveBox.get('accessToken', defaultValue: '') as String;
    final _refreshToken = _hiveBox.get('refreshToken', defaultValue: '') as String;

    if (_accessToken.isNotEmpty && _refreshToken.isNotEmpty) {
      return TokenModel(
        accessToken: _accessToken,
        refreshToken: _refreshToken,
      );
    }

    return null;
  }

  @override
  Future write(TokenModel token) async {
    await _hiveBox.putAll({
      'accessToken': token.accessToken,
      'refreshToken': token.refreshToken,
    });
  }

  @override
  Future delete() async {
    await _hiveBox.putAll({
      'accessToken': '',
      'refreshToken': '',
    });
  }
}
