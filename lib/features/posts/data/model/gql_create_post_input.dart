import 'package:picnic_app/features/posts/data/model/gql_image_post_content_input.dart';
import 'package:picnic_app/features/posts/data/model/gql_link_post_content_input.dart';
import 'package:picnic_app/features/posts/data/model/gql_poll_post_content_input.dart';
import 'package:picnic_app/features/posts/data/model/gql_text_post_content_input.dart';
import 'package:picnic_app/features/posts/data/model/gql_video_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content_input.dart';

class GqlCreatePostInput {
  const GqlCreatePostInput({
    required this.title,
    required this.type,
    required this.circleId,
    required this.videoContent,
    required this.textContent,
    required this.imageContent,
    required this.linkContent,
    required this.pollContent,
    required this.soundId,
  });

  factory GqlCreatePostInput.fromDomain(
    CreatePostInput input,
  ) {
    final content = input.content;

    return GqlCreatePostInput(
      title: '',
      //TODO there is no title to be passed in UI atm
      circleId: input.circleId.value,
      videoContent: content is VideoPostContentInput ? GqlVideoPostContentInput.fromDomain(content) : null,
      textContent: content is TextPostContentInput ? GqlTextPostContentInput.fromDomain(content) : null,
      imageContent: content is ImagePostContentInput ? GqlImagePostContentInput.fromDomain(content) : null,
      linkContent: content is LinkPostContentInput ? GqlLinkPostContentInput.fromDomain(content) : null,
      pollContent: content is PollPostContentInput ? GqlPollPostContentInput.fromDomain(content) : null,
      soundId: input.sound.id.value,
      type: content.type.value,
    );
  }

  final String title;
  final String circleId;
  final String type;
  final GqlVideoPostContentInput? videoContent;
  final GqlTextPostContentInput? textContent;
  final GqlImagePostContentInput? imageContent;
  final GqlLinkPostContentInput? linkContent;
  final GqlPollPostContentInput? pollContent;
  final String soundId;

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'circleId': circleId,
      'videoContent': videoContent?.toJson(),
      'textContent': textContent?.toJson(),
      'imageContent': imageContent?.toJson(),
      'linkContent': linkContent?.toJson(),
      'pollContent': pollContent?.toJson(),
      'soundId': soundId,
    };
  }
}
