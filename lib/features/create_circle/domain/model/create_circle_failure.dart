import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class CreateCircleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateCircleFailure.unknown([this.cause]) : type = CreateCircleFailureType.unknown;

  const CreateCircleFailure.circleNameTaken([this.cause]) : type = CreateCircleFailureType.circleNameTaken;

  final CreateCircleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateCircleFailureType.unknown:
        return DisplayableFailure.commonError();
      case CreateCircleFailureType.circleNameTaken:

        /// This is a hardcoded string here for now, because this needs to come from backend
        /// TODO: https://picnic-app.atlassian.net/browse/GS-3932
        return DisplayableFailure.commonError(appLocalizations.circleNameExistsError);
    }
  }

  @override
  String toString() => 'CreateCircleFailure{type: $type, cause: $cause}';
}

enum CreateCircleFailureType {
  unknown,
  circleNameTaken,
}
