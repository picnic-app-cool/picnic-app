import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SearchUsersFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SearchUsersFailure.unknown([this.cause]) : type = SearchFailureType.unknown;

  final SearchFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SearchFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SearchFailure{type: $type, cause: $cause}';
}

enum SearchFailureType {
  unknown,
}
