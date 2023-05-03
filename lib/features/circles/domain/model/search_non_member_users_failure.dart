import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SearchNonMemberUsersFailure implements HasDisplayableFailure {
  const SearchNonMemberUsersFailure({
    required this.type,
    required this.cause,
  });

  // ignore: avoid_field_initializers_in_const_classes
  const SearchNonMemberUsersFailure.unknown([this.cause]) : type = SearchNonMemberUsersFailureType.unknown;

  final SearchNonMemberUsersFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SearchNonMemberUsersFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SearchNonMemberUsersFailure{type: $type, cause: $cause}';
}

enum SearchNonMemberUsersFailureType {
  unknown,
}
