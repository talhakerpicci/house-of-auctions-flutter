import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:house_of_auctions/domain/models/core/app_data_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
@preResolve
class HiveDataStorage {
  final Box<dynamic> _hiveBox;

  HiveDataStorage(this._hiveBox);

  @factoryMethod
  static Future<HiveDataStorage> create() async {
    await Hive.initFlutter();
    final box = await Hive.openBox('appData');

    return HiveDataStorage(box);
  }

  AppDataModel read() {
    final _showIntro = _hiveBox.get('showIntro', defaultValue: null) as bool;

    return AppDataModel(showIntro: _showIntro);
  }

  Future write(AppDataModel data) async {
    await _hiveBox.putAll({
      'showIntro': data.showIntro,
    });
  }

  Future delete() async {
    await _hiveBox.putAll({
      'showIntro': null,
    });
  }
}
