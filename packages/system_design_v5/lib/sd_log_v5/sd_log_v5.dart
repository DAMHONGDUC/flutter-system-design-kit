import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as log;

class SdLogV5 {
  static String getMsgWithColor(String msg) {
    return '\x1B[32m$msg\x1B[0m';
  }

  static log.Logger logger = log.Logger(
    printer: log.PrettyPrinter(
      methodCount: 0,
      colors: false,
      dateTimeFormat: log.DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );
  static log.Logger errorLogger = log.Logger(
    printer: log.PrettyPrinter(
      colors: false,
      methodCount: 8,
      errorMethodCount: 8,
    ),
  );
  static log.Logger simpleLogger = log.Logger(printer: log.SimplePrinter());

  static void i(dynamic data) {
    if (kReleaseMode) {
      return;
    }
    logger.i(data);
  }

  static void d(dynamic data) {
    if (kReleaseMode) {
      return;
    }
    logger.d(data);
  }

  static void e(String tag, dynamic data) {
    if (kReleaseMode) {
      return;
    }
    errorLogger.e('$tag: $data');
  }

  static void simple(dynamic data) {
    if (kReleaseMode) {
      return;
    }
    simpleLogger.i(data);
  }

  static void d2(dynamic data1, dynamic data2) {
    if (kReleaseMode) {
      return;
    }
    logger.d('$data1 $data2');
  }

  static void printInfo(String text) {
    if (kReleaseMode) {
      return;
    }
    debugPrint('[INFO] => $text');
  }

  static void printError(String text) {
    if (kReleaseMode) {
      return;
    }
    debugPrint('[ERROR] => $text');
  }

  static void normalDebug(Object? object) {
    if (kReleaseMode) {
      return;
    }
    debugPrint('DEBUG => $object');
  }

  static void printWarning(String message, {bool showMsgWrap = true}) {
    if (kReleaseMode) {
      return;
    }

    developer.log(
      showMsgWrap
          ? getMsgWithColor('[WARNING] $message')
          : getMsgWithColor(message),
    );
  }
}
