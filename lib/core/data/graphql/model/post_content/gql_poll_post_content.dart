import 'package:picnic_app/core/data/graphql/model/gql_poll_answer.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';

class GqlPollPostContent {
  const GqlPollPostContent({
    required this.question,
    required this.answers,
    required this.votesTotal,
    required this.votedAnswerId,
  });

  factory GqlPollPostContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlPollPostContent(
      question: asT<String>(json, 'question'),
      answers: asList(
        json,
        'answers',
        GqlPollAnswer.fromJson,
      ),
      votesTotal: asT<int>(json, 'votesTotal'),
      votedAnswerId: asT<String>(json, 'votedAnswer'),
    );
  }

  final String question;
  final List<GqlPollAnswer> answers;
  final int votesTotal;
  final String? votedAnswerId;

  PollPostContent toDomain() => PollPostContent(
        question: question,
        answers: answers.map((e) => e.toDomain()).toList(),
        votesTotal: votesTotal,
        votedAnswerId: Id(votedAnswerId ?? ''),
      );
}
