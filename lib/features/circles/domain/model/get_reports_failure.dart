import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetReportsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetReportsFailure.unknown([this.cause]) : type = GetReportsFailureType.unknown;

  final GetReportsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetReportsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetBannedUsersFailure{type: $type, cause: $cause}';
}

enum GetReportsFailureType {
  unknown,
}
