import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_data_model.freezed.dart';
part 'app_data_model.g.dart';

@freezed
class AppDataModel with _$AppDataModel {
  const factory AppDataModel({
    required bool skipIntro,
  }) = _AppDataModel;

  factory AppDataModel.initial() => const AppDataModel(skipIntro: false);

  factory AppDataModel.fromJson(Map<String, dynamic> json) => _$AppDataModelFromJson(json);
}
