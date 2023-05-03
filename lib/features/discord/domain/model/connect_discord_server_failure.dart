import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ConnectDiscordServerFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ConnectDiscordServerFailure.unknown([this.cause]) : type = ConnectDiscordServerFailureType.unknown;

  final ConnectDiscordServerFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ConnectDiscordServerFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ConnectDiscordServerFailure{type: $type, cause: $cause}';
}

enum ConnectDiscordServerFailureType {
  unknown,
}
