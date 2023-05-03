import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class GetLinkMetadataFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetLinkMetadataFailure.unknown([this.cause]) : type = GetLinkMetadataFailureType.unknown;

  const GetLinkMetadataFailure.invalidLink([this.cause]) : type = GetLinkMetadataFailureType.invalidLink;

  final GetLinkMetadataFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetLinkMetadataFailureType.unknown:
        return DisplayableFailure.commonError();
      case GetLinkMetadataFailureType.invalidLink:
        return DisplayableFailure(
          title: appLocalizations.commonErrorTitle,
          message: appLocalizations.invalidLinkMessage,
        );
    }
  }

  @override
  String toString() => 'GetLinkMetadataFailure{type: $type, cause: $cause}';
}

enum GetLinkMetadataFailureType {
  unknown,
  invalidLink,
}
