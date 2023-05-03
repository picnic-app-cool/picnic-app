import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetDiscordConfigFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetDiscordConfigFailure.unknown([this.cause]) : type = GetDiscordServerFailureType.unknown;

  final GetDiscordServerFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetDiscordServerFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetDiscordServerFailure{type: $type, cause: $cause}';
}

enum GetDiscordServerFailureType {
  unknown,
}
