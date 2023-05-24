import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserScopedPodTokenFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserScopedPodTokenFailure.unknown([this.cause]) : type = GetUserScopedPodTokenFailureType.unknown;

  final GetUserScopedPodTokenFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserScopedPodTokenFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUserScopedPodTokenFailure{type: $type, cause: $cause}';
}

enum GetUserScopedPodTokenFailureType {
  unknown,
}
