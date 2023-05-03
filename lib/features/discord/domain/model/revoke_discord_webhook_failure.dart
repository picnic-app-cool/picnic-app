import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RevokeDiscordWebhookFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RevokeDiscordWebhookFailure.unknown([this.cause]) : type = RevokeDiscordWebhookFailureType.unknown;

  final RevokeDiscordWebhookFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RevokeDiscordWebhookFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RevokeDiscordWebhookFailure{type: $type, cause: $cause}';
}

enum RevokeDiscordWebhookFailureType {
  unknown,
}
