import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert_model.freezed.dart';

enum AlertType { info, success, error }

@freezed
class AlertModel with _$AlertModel {
  const factory AlertModel({
    required String message,
    required AlertType type,
  }) = _AlertModel;
}
