//ignore_for_file: forbidden_import_in_domain
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/debug/domain/model/prepare_logs_file_failure.dart';

class PrepareLogsFileUseCase {
  const PrepareLogsFileUseCase();

  Future<Either<PrepareLogsFileFailure, File>> execute({required String logs}) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File("${dir.path}/logsFile.txt");
      await file.writeAsString(logs);
      return success(file);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(PrepareLogsFileFailure.unknown(ex));
    }
  }
}
