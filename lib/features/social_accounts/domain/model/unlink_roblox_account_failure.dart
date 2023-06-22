import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnlinkRobloxAccountFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnlinkRobloxAccountFailure.unknown([this.cause]) : type = UnlinkRobloxAccountFailureType.unknown;

  final UnlinkRobloxAccountFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnlinkRobloxAccountFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UnlinkRobloxAccountFailure{type: $type, cause: $cause}';
}

enum UnlinkRobloxAccountFailureType {
  unknown,
}
