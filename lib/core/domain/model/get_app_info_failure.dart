import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetAppInfoFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetAppInfoFailure.unknown([this.cause]) : type = GetAppInfoFailureType.unknown;

  final GetAppInfoFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetAppInfoFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetAppInfoFailure{type: $type, cause: $cause}';
}

enum GetAppInfoFailureType {
  unknown,
}
