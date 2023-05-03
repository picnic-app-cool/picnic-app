import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/copy_text_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class CopyTextUseCase {
  const CopyTextUseCase(this._clipboardManager);

  final ClipboardManager _clipboardManager;

  Future<Either<CopyTextFailure, Unit>> execute({required String text}) async {
    await _clipboardManager.saveText(text);
    return success(unit);
  }
}
