import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetElectionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetElectionFailure.unknown([this.cause]) : type = GetElectionFailureType.unknown;

  final GetElectionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetElectionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetElectionFailure{type: $type, cause: $cause}';
}

enum GetElectionFailureType {
  unknown,
}
