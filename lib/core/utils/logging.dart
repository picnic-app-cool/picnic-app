import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:picnic_app/core/data/firebase/crashlytics_logger.dart';
import 'package:picnic_app/main.dart';

MemoryOutput logMemory = MemoryOutput(
  bufferSize: 100,
);

Logger _logger = Logger(
  level: kReleaseMode ? Level.error : Level.verbose,
  filter: _PicnicLogFilter(),
  printer: PrettyPrinter(
    colors: false,
    methodCount: 0,
    errorMethodCount: 100,
  ),
  output: MultiOutput(
    [
      logMemory,
      if (!isUnitTests) ConsoleOutput(),
    ],
  ),
);

//ignore: long-parameter-list
void logError(
  dynamic error, {
  StackTrace? stack,
  String? reason,
  bool logToCrashlytics = true,
  bool fatal = false,
}) {
  if (logToCrashlytics) {
    CrashlyticsLogger.logError(
      error,
      stack: stack,
      reason: reason,
      fatal: fatal,
    );
  }
  _logger.e(
    reason,
    error,
    stack ?? StackTrace.current,
  );
}

void debugLog(
  String message, [
  dynamic caller,
]) {
  _logger.d(
    caller == null ? message : '${caller.runtimeType}: $message',
  );
}

//ignore: prefer-match-file-name
class _PicnicLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return !kReleaseMode || event.level.index > Level.warning.index;
  }
}
