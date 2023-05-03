import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/debug/domain/use_cases/prepare_logs_file_use_case.dart';
import 'package:picnic_app/features/debug/log_console/log_console_navigator.dart';
import 'package:picnic_app/features/debug/log_console/log_console_presentation_model.dart';

class LogConsolePresenter extends Cubit<LogConsoleViewModel> {
  LogConsolePresenter(
    LogConsolePresentationModel model,
    this.navigator,
    this._prepareLogsFileUseCase,
  ) : super(model);

  final LogConsoleNavigator navigator;
  final PrepareLogsFileUseCase _prepareLogsFileUseCase;

  // ignore: unused_element
  LogConsolePresentationModel get _model => state as LogConsolePresentationModel;

  void onTapRefresh() {
    _refreshLog();
  }

  void onInit() => _refreshLog();

  Future<void> onTapSend() async {
    await _prepareLogsFileUseCase.execute(logs: _model.logText).doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (file) => navigator.shareFiles(files: [file.path]),
        );
  }

  void onTapClear() {
    logMemory.buffer.clear();
    _updateModelWithLogs();
  }

  void _refreshLog() {
    _updateModelWithLogs();
  }

  void _updateModelWithLogs() {
    return tryEmit(
      _model.copyWith(
        logEntries: logMemory.buffer.toList(),
      ),
    );
  }
}
