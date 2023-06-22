import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LinkDiscordAccountFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LinkDiscordAccountFailure.unknown([this.cause]) : type = LinkDiscordAccountFailureType.unknown;

  final LinkDiscordAccountFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LinkDiscordAccountFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LinkDiscordAccountFailure{type: $type, cause: $cause}';
}

enum LinkDiscordAccountFailureType {
  unknown,
}
