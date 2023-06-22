import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnlinkDiscordAccountFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnlinkDiscordAccountFailure.unknown([this.cause]) : type = UnlinkDiscordAccountFailureType.unknown;

  final UnlinkDiscordAccountFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnlinkDiscordAccountFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UnlinkDiscordAccountFailure{type: $type, cause: $cause}';
}

enum UnlinkDiscordAccountFailureType {
  unknown,
}
