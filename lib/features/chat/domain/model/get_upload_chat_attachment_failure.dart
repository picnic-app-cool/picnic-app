import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUploadChatAttachmentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUploadChatAttachmentFailure.unknown([this.cause]) : type = GetUploadChatAttachmentFailureType.unknown;

  final GetUploadChatAttachmentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUploadChatAttachmentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUploadChatAttachmentFailure{type: $type, cause: $cause}';
}

enum GetUploadChatAttachmentFailureType {
  unknown,
}
