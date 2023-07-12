import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetRecommendedChatsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetRecommendedChatsFailure.unknown([this.cause]) : type = GetRecommendedChatsFailureType.unknown;

  final GetRecommendedChatsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetRecommendedChatsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetRecommendedChatsFailure{type: $type, cause: $cause}';
}

enum GetRecommendedChatsFailureType {
  unknown,
}
