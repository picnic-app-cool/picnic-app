import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

class PollPostContent extends Equatable implements PostContent {
  const PollPostContent({
    required this.question,
    required this.answers,
    required this.votesTotal,
    required this.votedAnswerId,
  });

  const PollPostContent.empty()
      : question = '',
        answers = const [],
        votesTotal = 0,
        votedAnswerId = const Id.empty();

  final String question;
  final List<PollAnswer> answers;
  final int votesTotal;

  ///optional id of the answer given user voted. Id.none() if user didn't vote
  final Id votedAnswerId;

  PollAnswer get leftPollAnswer {
    assert(answers.isNotEmpty, "polls should always have 2 distinct answers");
    return answers.first;
  }

  PollAnswer get rightPollAnswer => answers.isNotEmpty ? answers[1] : const PollAnswer.empty();

  double get leftVotesPercentage => votesTotal == 0 ? 0 : leftPollAnswer.votesCount.toDouble() / votesTotal;

  double get rightVotesPercentage => votesTotal == 0 ? 0 : rightPollAnswer.votesCount.toDouble() / votesTotal;

  @override
  List<Object?> get props => [
        question,
        answers,
        votesTotal,
        votedAnswerId,
      ];

  @override
  PostType get type => PostType.poll;

  PollPostContent copyWith({
    String? question,
    List<PollAnswer>? answers,
    int? votesTotal,
    Id? votedAnswerId,
  }) {
    return PollPostContent(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      votesTotal: votesTotal ?? this.votesTotal,
      votedAnswerId: votedAnswerId ?? this.votedAnswerId,
    );
  }
}
