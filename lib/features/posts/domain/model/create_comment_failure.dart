import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class CreateCommentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateCommentFailure.unknown([this.cause]) : type = CreateCommentFailureType.unknown;

  const CreateCommentFailure.permissionDenied([this.cause]) : type = CreateCommentFailureType.permissionDenied;

  final CreateCommentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateCommentFailureType.unknown:
        return DisplayableFailure.commonError();
      case CreateCommentFailureType.permissionDenied:
        return DisplayableFailure.commonError(appLocalizations.disabledCommentsLabel);
    }
  }

  @override
  String toString() => 'CreateCommentFailure{type: $type, cause: $cause}';
}

enum CreateCommentFailureType {
  unknown,
  permissionDenied,
}
