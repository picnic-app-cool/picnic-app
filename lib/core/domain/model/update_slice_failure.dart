import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class UpdateSliceFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateSliceFailure.unknown([this.cause]) : type = UpdateSliceFailureType.unknown;

  const UpdateSliceFailure.circleNameTaken([this.cause]) : type = UpdateSliceFailureType.sliceNameTaken;

  final UpdateSliceFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateSliceFailureType.unknown:
        return DisplayableFailure.commonError();
      case UpdateSliceFailureType.sliceNameTaken:
        return DisplayableFailure.commonError(appLocalizations.sliceNameExistsError);
    }
  }

  @override
  String toString() => 'UpdateSliceFailure{type: $type, cause: $cause}';
}

enum UpdateSliceFailureType {
  unknown,
  sliceNameTaken,
}
