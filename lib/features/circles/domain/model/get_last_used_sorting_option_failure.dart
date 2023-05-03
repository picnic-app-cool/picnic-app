import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetLastUsedSortingOptionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetLastUsedSortingOptionFailure.unknown([this.cause]) : type = GetLastUsedSortingOptionFailureType.unknown;

  final GetLastUsedSortingOptionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetLastUsedSortingOptionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetLastUsedSortingOptionFailure{type: $type, cause: $cause}';
}

enum GetLastUsedSortingOptionFailureType {
  unknown,
}
