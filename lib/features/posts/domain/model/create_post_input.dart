import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_with_caption.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';

class CreatePostInput extends Equatable {
  const CreatePostInput({
    required this.circleId,
    required this.content,
    required this.sound,
  });

  const CreatePostInput.empty()
      : content = const TextPostContentInput.empty(),
        sound = const Sound.empty(),
        circleId = const Id('');

  /// circle to which the given is being posted. User must be a member of that circle
  final Id circleId;
  final PostContentInput content;
  final Sound sound;

  /// based on the type, provide one of the following contents. it can be only one content per input
  PostType get type => content.type;

  bool get withCaption => content is PostWithCaption;

  @override
  List<Object> get props => [
        sound,
        circleId,
        content,
      ];

  CreatePostInput copyWith({
    Id? circleId,
    PostContentInput? content,
    Sound? sound,
  }) {
    return CreatePostInput(
      circleId: circleId ?? this.circleId,
      content: content ?? this.content,
      sound: sound ?? this.sound,
    );
  }
}
