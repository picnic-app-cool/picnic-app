import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SendGlitterBombFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SendGlitterBombFailure.unknown([this.cause]) : type = SendGlitterBombFailureType.unknown;

  final SendGlitterBombFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SendGlitterBombFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SendGlitterBombFailure{type: $type, cause: $cause}';
}

enum SendGlitterBombFailureType {
  unknown,
}
