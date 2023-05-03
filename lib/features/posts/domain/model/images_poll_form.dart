import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer_input.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer_type.dart';
import 'package:picnic_app/features/posts/domain/model/poll_image_side.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';

class ImagesPollForm extends Equatable {
  const ImagesPollForm({
    required this.leftImagePath,
    required this.rightImagePath,
    required this.question,
    required this.sound,
    required this.leftMentionedUser,
    required this.rightMentionedUser,
  });

  const ImagesPollForm.empty()
      : question = '',
        sound = const Sound.empty(),
        leftImagePath = '',
        rightImagePath = '',
        leftMentionedUser = const UserMention.empty(),
        rightMentionedUser = const UserMention.empty();

  final String question;
  final String leftImagePath;
  final String rightImagePath;
  final Sound sound;
  final UserMention leftMentionedUser;
  final UserMention rightMentionedUser;

  @override
  List<Object> get props => [
        leftImagePath,
        rightImagePath,
        question,
        sound,
        leftMentionedUser,
        rightMentionedUser,
      ];

  ImagesPollForm byUpdatingImage({
    required PollImageSide side,
    required String path,
  }) {
    switch (side) {
      case PollImageSide.left:
        return copyWith(leftImagePath: path);
      case PollImageSide.right:
        return copyWith(rightImagePath: path);
    }
  }

  ImagesPollForm byUpdatingMentionedUser({
    required PollImageSide side,
    required UserMention userMention,
  }) {
    switch (side) {
      case PollImageSide.left:
        return copyWith(leftMentionedUser: userMention);
      case PollImageSide.right:
        return copyWith(rightMentionedUser: userMention);
    }
  }

  ImagesPollForm byRemovingSound() => copyWith(
        sound: const Sound.empty(),
      );

  ImagesPollForm byAddingSound(Sound sound) => copyWith(sound: sound);

  ImagesPollForm copyWith({
    String? question,
    String? leftImagePath,
    String? rightImagePath,
    Sound? sound,
    UserMention? leftMentionedUser,
    UserMention? rightMentionedUser,
  }) {
    return ImagesPollForm(
      question: question ?? this.question,
      leftImagePath: leftImagePath ?? this.leftImagePath,
      rightImagePath: rightImagePath ?? this.rightImagePath,
      sound: sound ?? this.sound,
      leftMentionedUser: leftMentionedUser ?? this.leftMentionedUser,
      rightMentionedUser: rightMentionedUser ?? this.rightMentionedUser,
    );
  }

  CreatePostInput toCreatePostInput() => CreatePostInput(
        circleId: const Id.empty(), // circle id is added in the last step
        content: PollPostContentInput(
          question: question,
          answers: [
            PollAnswerInput(
              answerType: PollAnswerType.image,
              imagePath: leftImagePath,
            ),
            PollAnswerInput(
              answerType: PollAnswerType.image,
              imagePath: rightImagePath,
            ),
          ],
        ),
        sound: sound,
      );
}
