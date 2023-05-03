import 'package:picnic_app/features/posts/data/model/gql_poll_answer_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content_input.dart';

class GqlPollPostContentInput {
  const GqlPollPostContentInput({
    required this.question,
    required this.answers,
  });

  factory GqlPollPostContentInput.fromDomain(PollPostContentInput input) => GqlPollPostContentInput(
        question: input.question.trim(),
        answers: input.answers.map((it) => GqlPollAnswerInput.fromDomain(it)).toList(),
      );

  final String question;
  final List<GqlPollAnswerInput> answers;

  Map<String, dynamic> toJson() => {
        'question': question,
        'answers': answers.map((it) => it.toJson()).toList(),
      };
}
