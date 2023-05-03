import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class VoteInPollInput extends Equatable {
  const VoteInPollInput({
    required this.postId,
    required this.answerId,
  });

  const VoteInPollInput.empty()
      : postId = const Id.empty(),
        answerId = const Id.empty();

  final Id postId;
  final Id answerId;

  @override
  List<Object> get props => [
        postId,
        answerId,
      ];

  VoteInPollInput copyWith({
    Id? postId,
    Id? answerId,
  }) {
    return VoteInPollInput(
      postId: postId ?? this.postId,
      answerId: answerId ?? this.answerId,
    );
  }
}
