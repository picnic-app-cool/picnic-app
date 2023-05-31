import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetTrendingPodsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetTrendingPodsFailure.unknown([this.cause]) : type = GetTrendingPodsFailureType.unknown;

  final GetTrendingPodsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetTrendingPodsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetTrendingPodsFailure{type: $type, cause: $cause}';
}

enum GetTrendingPodsFailureType {
  unknown,
}
