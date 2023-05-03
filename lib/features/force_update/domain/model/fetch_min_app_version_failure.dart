import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class FetchMinAppVersionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const FetchMinAppVersionFailure.unknown([this.cause]) : type = FetchMinAppVersionFailureType.unknown;

  final FetchMinAppVersionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case FetchMinAppVersionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'FetchMinAppVersionFailure{type: $type, cause: $cause}';
}

enum FetchMinAppVersionFailureType {
  unknown,
}
