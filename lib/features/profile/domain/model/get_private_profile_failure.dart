import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPrivateProfileFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPrivateProfileFailure.unknown([this.cause]) : type = GetPrivateProfileFailureType.unknown;

  final GetPrivateProfileFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPrivateProfileFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPrivateProfileUsecaseFailure{type: $type, cause: $cause}';
}

enum GetPrivateProfileFailureType {
  unknown,
}
