import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class FetchAppVersionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const FetchAppVersionFailure.unknown([this.cause]) : type = FetchAppVersionFailureType.unknown;

  final FetchAppVersionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case FetchAppVersionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'FetchAppVersionFailure{type: $type, cause: $cause}';
}

enum FetchAppVersionFailureType {
  unknown,
}
