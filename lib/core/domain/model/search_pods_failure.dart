import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SearchPodsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SearchPodsFailure.unknown([this.cause]) : type = SearchPodsFailureType.unknown;

  final SearchPodsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SearchPodsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SearchPodsFailure{type: $type, cause: $cause}';
}

enum SearchPodsFailureType {
  unknown,
}
