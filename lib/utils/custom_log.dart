import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logg = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

extension LoggerExtension on Logger {
  void dev(dynamic data, {String? tag, bool json = false}) {
    if (kReleaseMode) return;
    if (json) {
      developer.log('\n${jsonEncode(data)}', name: tag ?? '');
    } else {
      developer.log('\n$data', name: tag ?? '');
    }
  }
}