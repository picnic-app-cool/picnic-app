import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPhoneGalleryAssetsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPhoneGalleryAssetsFailure.unknown([this.cause]) : type = GetPhoneGalleryAssetsFailureType.unknown;

  final GetPhoneGalleryAssetsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPhoneGalleryAssetsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPhoneGalleryAssetsFailure{type: $type, cause: $cause}';
}

enum GetPhoneGalleryAssetsFailureType {
  unknown,
}
