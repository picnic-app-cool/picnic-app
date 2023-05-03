import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetIsBlurredAttachmentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetIsBlurredAttachmentFailure.unknown([this.cause]) : type = GetIsBlurredAttachmentFailureType.unknown;

  final GetIsBlurredAttachmentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetIsBlurredAttachmentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetIsBlurredAttachmentFailure{type: $type, cause: $cause}';
}

enum GetIsBlurredAttachmentFailureType {
  unknown,
}
