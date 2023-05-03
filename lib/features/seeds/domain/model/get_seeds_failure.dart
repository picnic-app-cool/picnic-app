import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSeedsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSeedsFailure.unknown([this.cause]) : type = GetSeedsFailureType.unknown;

  final GetSeedsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSeedsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSeedsFailure{type: $type, cause: $cause}';
}

enum GetSeedsFailureType {
  unknown,
}
