import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'env_model.freezed.dart';
part 'env_model.g.dart';

@freezed
@singleton
class EnvModel with _$EnvModel {
  factory EnvModel({
    required String env,
    required bool debug,
    required bool debugShowCheckedModeBanner,
    required bool debugShowMaterialGrid,
    required bool debugApiClient,
    required String apiBaseUrl,
  }) = _EnvModel;

  EnvModel._();

  @factoryMethod
  static Future<EnvModel> create() async {
    const env = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
    final rawEnvData = await rootBundle.loadString(
      'assets/config/$env.json',
    );
    final jsonEnvData = jsonDecode(rawEnvData) as Map<String, dynamic>;

    return EnvModel.fromJson(jsonEnvData);
  }

  bool get isRelease => env.split('_').contains('release');

  factory EnvModel.fromJson(Map<String, dynamic> json) => _$EnvModelFromJson(json);
}
