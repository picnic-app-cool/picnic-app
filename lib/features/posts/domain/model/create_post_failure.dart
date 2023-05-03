import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class CreatePostFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreatePostFailure.unknown([this.cause]) : type = CreatePostFailureType.unknown;

  const CreatePostFailure.fileTooBig([this.cause]) : type = CreatePostFailureType.fileTooBig;

  const CreatePostFailure.permissionDenied([this.cause]) : type = CreatePostFailureType.permissionDenied;

  final CreatePostFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreatePostFailureType.unknown:
        return DisplayableFailure.commonError();
      case CreatePostFailureType.fileTooBig:
        return DisplayableFailure.commonError(
          appLocalizations.fileTooBigErrorMessage,
        );
      case CreatePostFailureType.permissionDenied:
        return DisplayableFailure.commonError(
          appLocalizations.postingDisabled,
        );
    }
  }

  @override
  String toString() => 'CreatePostFailure{type: $type, cause: $cause}';
}

enum CreatePostFailureType { unknown, fileTooBig, permissionDenied }
