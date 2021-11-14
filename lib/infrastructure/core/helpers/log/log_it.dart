import 'dart:io' as io;
import 'package:house_of_auctions/infrastructure/core/constants/di.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class LogIt {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: io.stdout.supportsAnsiEscapes,
    ),
  );

  /// Log a message at level [Level.verbose].
  void verbose(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (env.isRelease && !showInProd) {
      return;
    }

    logger.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void debug(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (env.isRelease && !showInProd) {
      return;
    }

    logger.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void info(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (env.isRelease && !showInProd) {
      return;
    }

    logger.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void warn(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (env.isRelease && !showInProd) {
      return;
    }

    logger.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void error(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (env.isRelease && !showInProd) {
      return;
    }

    logger.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (env.isRelease && !showInProd) {
      return;
    }

    logger.wtf(message, error, stackTrace);
  }
}
