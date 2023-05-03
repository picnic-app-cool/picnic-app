import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class CreateSliceFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateSliceFailure.unknown([this.cause]) : type = CreateSliceFailureType.unknown;

  const CreateSliceFailure.circleNameTaken([this.cause]) : type = CreateSliceFailureType.sliceNameTaken;

  final CreateSliceFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateSliceFailureType.unknown:
        return DisplayableFailure.commonError();
      case CreateSliceFailureType.sliceNameTaken:
        return DisplayableFailure.commonError(appLocalizations.circleNameExistsError);
    }
  }

  @override
  String toString() => 'CreateSliceFailure{type: $type, cause: $cause}';
}

enum CreateSliceFailureType {
  unknown,
  sliceNameTaken,
}
