import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer_type.dart';

class PollAnswerInput extends Equatable {
  const PollAnswerInput({
    required this.answerType,
    required this.imagePath,
  });

  const PollAnswerInput.empty()
      : answerType = PollAnswerType.image,
        imagePath = '';

  final PollAnswerType answerType;
  final String imagePath;

  @override
  List<Object> get props => [
        answerType,
        imagePath,
      ];

  PollAnswerInput copyWith({
    PollAnswerType? answerType,
    String? imagePath,
  }) {
    return PollAnswerInput(
      answerType: answerType ?? this.answerType,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
