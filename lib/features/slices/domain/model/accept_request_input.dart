import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class AcceptRequestInput extends Equatable {
  const AcceptRequestInput({
    required this.sliceId,
    required this.userRequestedToJoinID,
  });

  const AcceptRequestInput.empty()
      : sliceId = const Id.empty(),
        userRequestedToJoinID = const Id.empty();

  final Id sliceId;
  final Id userRequestedToJoinID;

  @override
  List<Object> get props => [
        sliceId,
        userRequestedToJoinID,
      ];

  AcceptRequestInput copyWith({
    Id? sliceId,
    Id? userRequestedToJoinID,
  }) {
    return AcceptRequestInput(
      sliceId: sliceId ?? this.sliceId,
      userRequestedToJoinID: userRequestedToJoinID ?? this.userRequestedToJoinID,
    );
  }
}
