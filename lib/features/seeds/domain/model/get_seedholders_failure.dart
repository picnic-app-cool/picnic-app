import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSeedHoldersFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSeedHoldersFailure.unknown([this.cause]) : type = GetSeedholdersFailureType.unknown;

  final GetSeedholdersFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSeedholdersFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSeedholdersFailure{type: $type, cause: $cause}';
}

enum GetSeedholdersFailureType {
  unknown,
}
