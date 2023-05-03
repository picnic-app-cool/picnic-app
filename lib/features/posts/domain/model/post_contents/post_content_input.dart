import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

abstract class PostContentInput {
  PostType get type;

  static PostContentInput empty() => const TextPostContentInput.empty();
}

extension PostContentInputSwitch on PostContentInput {
  // ignore: long-parameter-list
  T when<T>({
    required T Function(TextPostContentInput content) textPostContent,
    required T Function(ImagePostContentInput content) imagePostContent,
    required T Function(LinkPostContentInput content) linkPostContent,
    required T Function(VideoPostContentInput content) videoPostContent,
    required T Function(PollPostContentInput content) pollPostContent,
    required T Function() unknownContent,
  }) {
    switch (type) {
      case PostType.text:
        return textPostContent(cast(this));
      case PostType.image:
        return imagePostContent(cast(this));
      case PostType.video:
        return videoPostContent(cast(this));
      case PostType.link:
        return linkPostContent(cast(this));
      case PostType.poll:
        return pollPostContent(cast(this));
      case PostType.unknown:
        return unknownContent();
    }
  }
}

extension PostContentInputMapper on PostContentInput {
  PostContent toPostContent() {
    return when(
      textPostContent: (input) => input.toPostContent(),
      imagePostContent: (input) => input.toPostContent(),
      linkPostContent: (input) => input.toPostContent(),
      videoPostContent: (input) => input.toPostContent(),
      pollPostContent: (input) => input.toPostContent(),
      unknownContent: () => const TextPostContent.empty(),
    );
  }
}

extension TextPostContentInputMapper on TextPostContentInput {
  TextPostContent toPostContent() => TextPostContent(
        additionalText: additionalText,
        text: text,
        color: color,
      );
}

extension ImagePostContentInputMapper on ImagePostContentInput {
  ImagePostContent toPostContent() => ImagePostContent(
        imageUrl: ImageUrl(imageFilePath),
        text: text,
      );
}

extension LinkPostContentInputMapper on LinkPostContentInput {
  LinkPostContent toPostContent() => const LinkPostContent.empty().copyWith(
        linkUrl: linkUrl,
      );
}

extension VideoPostContentInputMapper on VideoPostContentInput {
  VideoPostContent toPostContent() => const VideoPostContent.empty().copyWith(
        videoUrl: VideoUrl(videoFilePath),
      );
}

extension PollPostContentInputMapper on PollPostContentInput {
  PollPostContent toPostContent() => const PollPostContent.empty().copyWith(
        question: question,
        answers: answers.map((answer) => answer.toPollAnswer()).toList(),
      );
}

extension PollAnswerInputMapper on PollAnswerInput {
  PollAnswer toPollAnswer() => const PollAnswer.empty().copyWith(
        imageUrl: ImageUrl(imagePath),
      );
}
