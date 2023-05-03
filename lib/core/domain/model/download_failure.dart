import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class DownloadFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DownloadFailure.unknown([this.cause]) : type = DownloadFailureType.unknown;

  final DownloadFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case DownloadFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'DownloadFailure{type: $type, cause: $cause}';
}

enum DownloadFailureType {
  unknown,
}
