import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_data_model.freezed.dart';
part 'app_data_model.g.dart';

@freezed
class AppDataModel with _$AppDataModel {
  const factory AppDataModel({
    required bool showIntro,
  }) = _AppDataModel;

  factory AppDataModel.initial() => const AppDataModel(showIntro: true);

  factory AppDataModel.fromJson(Map<String, dynamic> json) => _$AppDataModelFromJson(json);
}
