//ignore_for_file: forbidden_import_in_presentation
import 'package:collection/collection.dart';
import 'package:logger/logger.dart';
import 'package:picnic_app/features/debug/log_console/log_console_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LogConsolePresentationModel implements LogConsoleViewModel {
  /// Creates the initial state
  LogConsolePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LogConsoleInitialParams initialParams,
  ) : logEntries = const [];

  /// Used for the copyWith method
  LogConsolePresentationModel._({
    required this.logEntries,
  });

  @override
  final List<OutputEvent> logEntries;

  String get logText => logEntries.map((e) => e.lines).flattened.join("\n");

  LogConsolePresentationModel copyWith({
    List<OutputEvent>? logEntries,
  }) {
    return LogConsolePresentationModel._(
      logEntries: logEntries ?? this.logEntries,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LogConsoleViewModel {
  List<OutputEvent> get logEntries;
}
