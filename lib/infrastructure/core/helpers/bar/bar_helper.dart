import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/gradients.dart';

class BarHelper {
  /// Show an alert
  static void showAlert(
    BuildContext context, {
    required AlertModel alert,
    bool showAboveBottomBar = false,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) {
    if (alert.type == AlertType.info) {
      _createAlertModal(
        message: alert.message,
        iconWidget: const Icon(
          Icons.info,
          color: Colors.white,
        ),
        backgroundGradient: Gradients.getDefaultGradient(Gradients.green),
        showAboveBottomBar: showAboveBottomBar,
        position: position,
      ).show(context);
    } else if (alert.type == AlertType.success) {
      _createAlertModal(
        message: alert.message,
        iconWidget: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        backgroundGradient: Gradients.getDefaultGradient(Gradients.green),
        showAboveBottomBar: showAboveBottomBar,
        position: position,
      ).show(context);
    } else if (alert.type == AlertType.error) {
      _createAlertModal(
        message: alert.message,
        iconWidget: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
        backgroundGradient: Gradients.getDefaultGradient(Gradients.red),
        showAboveBottomBar: showAboveBottomBar,
        position: position,
      ).show(context);
    }
  }

  static Flushbar _createAlertModal({
    required String message,
    required Widget iconWidget,
    Gradient? backgroundGradient,
    String? title,
    Duration duration = const Duration(seconds: 3),
    bool showAboveBottomBar = false,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) {
    return Flushbar(
      title: title,
      message: message,
      icon: Padding(
        padding: const EdgeInsets.all(8),
        child: iconWidget,
      ),
      backgroundColor: Colors.green,
      backgroundGradient: backgroundGradient,
      messageSize: 16,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      margin: EdgeInsets.only(bottom: showAboveBottomBar ? 60 : 8, right: 8, left: 8),
      shouldIconPulse: false,
      flushbarPosition: position,
      duration: duration,
    );
  }
}
