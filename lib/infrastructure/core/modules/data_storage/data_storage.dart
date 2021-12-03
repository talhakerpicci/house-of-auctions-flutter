import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:house_of_auctions/domain/models/core/app_data_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@preResolve
class HiveDataStorage {
  final Box<dynamic> _hiveBox;

  HiveDataStorage(this._hiveBox);

  @factoryMethod
  static Future<HiveDataStorage> create() async {
    final box = await Hive.openBox('appData');

    return HiveDataStorage(box);
  }

  AppDataModel read() {
    final _skipIntro = _hiveBox.get('skipIntro') as bool;

    return AppDataModel(skipIntro: _skipIntro);
  }

  Future write(AppDataModel data) async {
    await _hiveBox.putAll({
      'skipIntro': data.skipIntro,
    });
  }

  Future delete() async {
    await _hiveBox.putAll({
      'skipIntro': null,
    });
  }
}
