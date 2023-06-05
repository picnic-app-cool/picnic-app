import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPodsTagsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPodsTagsFailure.unknown([this.cause]) : type = GetPodsTagsFailureType.unknown;

  final GetPodsTagsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPodsTagsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPodsTagsFailure{type: $type, cause: $cause}';
}

enum GetPodsTagsFailureType {
  unknown,
}
