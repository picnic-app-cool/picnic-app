import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPopularFeedFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPopularFeedFailure.unknown([this.cause]) : type = GetPopularFeedFailureType.unknown;

  final GetPopularFeedFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPopularFeedFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPopularFeedFailure{type: $type, cause: $cause}';
}

enum GetPopularFeedFailureType {
  unknown,
}
