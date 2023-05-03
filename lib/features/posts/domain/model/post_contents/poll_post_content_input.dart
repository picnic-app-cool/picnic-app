import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

class PollPostContentInput extends Equatable implements PostContentInput {
  const PollPostContentInput({
    required this.question,
    required this.answers,
  });

  const PollPostContentInput.empty()
      : question = '',
        answers = const [];

  final String question;
  final List<PollAnswerInput> answers;

  @override
  List<Object?> get props => [
        question,
        answers,
      ];

  @override
  PostType get type => PostType.poll;

  PollPostContentInput copyWith({
    String? question,
    List<PollAnswerInput>? answers,
  }) {
    return PollPostContentInput(
      question: question ?? this.question,
      answers: answers ?? this.answers,
    );
  }
}
