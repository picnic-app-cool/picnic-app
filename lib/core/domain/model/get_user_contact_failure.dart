import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserContactFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserContactFailure.unknown([this.cause]) : type = GetUserContactFailureType.unknown;

  final GetUserContactFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserContactFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUserContactFailure{type: $type, cause: $cause}';
}

enum GetUserContactFailureType {
  unknown,
}
