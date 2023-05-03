import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

abstract class PostContent {
  PostType get type;
}

extension PostContentSwitch on PostContent {
  // ignore: long-parameter-list
  T when<T>({
    required T Function(TextPostContent content) textPostContent,
    required T Function(ImagePostContent content) imagePostContent,
    required T Function(LinkPostContent content) linkPostContent,
    required T Function(VideoPostContent content) videoPostContent,
    required T Function(PollPostContent content) pollPostContent,
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
