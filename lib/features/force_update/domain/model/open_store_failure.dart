import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class OpenStoreFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const OpenStoreFailure.unknown([this.cause]) : type = OpenStoreFailureType.unknown;
  const OpenStoreFailure.cantLaunchUrl([this.cause]) : type = OpenStoreFailureType.cantLaunchUrl;

  final OpenStoreFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case OpenStoreFailureType.unknown:
        return DisplayableFailure.commonError();
      case OpenStoreFailureType.cantLaunchUrl:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'OpenStoreFailureType {type: $type, cause: $cause}';
}

enum OpenStoreFailureType {
  unknown,
  cantLaunchUrl,
}
