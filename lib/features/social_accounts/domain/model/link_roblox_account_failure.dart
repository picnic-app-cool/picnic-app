import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LinkRobloxAccountFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LinkRobloxAccountFailure.unknown([this.cause]) : type = LinkRobloxAccountFailureType.unknown;

  final LinkRobloxAccountFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LinkRobloxAccountFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LinkRobloxAccountFailure{type: $type, cause: $cause}';
}

enum LinkRobloxAccountFailureType {
  unknown,
}
