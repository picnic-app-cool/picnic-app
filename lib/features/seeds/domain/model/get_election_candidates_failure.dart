import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetElectionCandidatesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetElectionCandidatesFailure.unknown([this.cause]) : type = GetElectionCandidatesFailureType.unknown;

  final GetElectionCandidatesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetElectionCandidatesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetElectionCandidatesFailure{type: $type, cause: $cause}';
}

enum GetElectionCandidatesFailureType {
  unknown,
}
