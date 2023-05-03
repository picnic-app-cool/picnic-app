import 'package:picnic_app/core/data/graphql/model/gql_basic_circle.dart';
import 'package:picnic_app/core/data/graphql/model/gql_basic_public_profile.dart';
import 'package:picnic_app/core/data/graphql/model/gql_sound.dart';
import 'package:picnic_app/core/data/graphql/model/post_content/gql_image_post_content.dart';
import 'package:picnic_app/core/data/graphql/model/post_content/gql_link_post_content.dart';
import 'package:picnic_app/core/data/graphql/model/post_content/gql_poll_post_content.dart';
import 'package:picnic_app/core/data/graphql/model/post_content/gql_text_post_content.dart';
import 'package:picnic_app/core/data/graphql/model/post_content/gql_video_post_content.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class GqlPost {
  const GqlPost({
    required this.id,
    required this.author,
    required this.circle,
    required this.commentsCount,
    required this.type,
    required this.textContent,
    required this.linkContent,
    required this.imageContent,
    required this.videoContent,
    required this.pollContent,
    required this.likesCount,
    required this.title,
    required this.sound,
    required this.viewsCount,
    required this.savesCount,
    required this.sharesCount,
    required this.iReacted,
    required this.iSaved,
    required this.shareLink,
    required this.createdAt,
  });

  factory GqlPost.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlPost(
      id: asT<String>(json, 'id'),
      author: GqlBasicPublicProfile.fromJson(
        asT<Map<String, dynamic>>(json, 'author'),
      ),
      circle: GqlBasicCircle.fromJson(
        asT<Map<String, dynamic>>(json, 'circle'),
      ),
      commentsCount: asT<int>(json, 'commentsCount'),
      type: asT<String>(json, 'type'),
      textContent: GqlTextPostContent.fromJson(asT<Map<String, dynamic>>(json, 'textContent')),
      linkContent: GqlLinkPostContent.fromJson(asT<Map<String, dynamic>>(json, 'linkContent')),
      imageContent: GqlImagePostContent.fromJson(asT<Map<String, dynamic>>(json, 'imageContent')),
      videoContent: GqlVideoPostContent.fromJson(asT<Map<String, dynamic>>(json, 'videoContent')),
      pollContent: GqlPollPostContent.fromJson(asT<Map<String, dynamic>>(json, 'pollContent')),
      likesCount: asT<int>(json, 'likesCount'),
      title: asT<String>(json, 'title'),
      sound: GqlSound.fromJson(
        asT<Map<String, dynamic>>(json, 'sound'),
      ),
      viewsCount: asT<int>(json, 'viewsCount'),
      savesCount: asT<int>(json, 'savesCount'),
      sharesCount: asT<int>(json, 'sharesCount'),
      iReacted: asT<bool>(json, 'iReacted'),
      iSaved: asT<bool>(json, 'iSaved'),
      shareLink: asT<String>(json, 'shareLink'),
      createdAt: asT<String>(json, 'createdAt'),
    );
  }

  final String? id;

  final GqlBasicPublicProfile author;

  final GqlBasicCircle circle;

  final int commentsCount;

  final String type;

  final GqlTextPostContent textContent;

  final GqlLinkPostContent linkContent;

  final GqlImagePostContent imageContent;

  final GqlVideoPostContent videoContent;

  final GqlPollPostContent pollContent;

  final int likesCount;

  final String title;

  final int viewsCount;

  final int savesCount;

  final int sharesCount;

  final GqlSound sound;

  final bool iReacted;

  final bool iSaved;

  final String shareLink;

  final String createdAt;

  PostContent get domainContent {
    final postType = PostType.fromString(type);
    switch (postType) {
      case PostType.text:
        return textContent.toDomain();
      case PostType.image:
        return imageContent.toDomain();
      case PostType.video:
        return videoContent.toDomain();
      case PostType.link:
        return linkContent.toDomain();
      case PostType.poll:
        return pollContent.toDomain();
      case PostType.unknown:
        return textContent.toDomain();
    }
  }

  Post toDomain(UserStore userStore) => Post(
        id: Id(id ?? ""),
        author: author.toDomain(userStore),
        circle: circle.toDomain(),
        commentsCount: commentsCount,
        content: domainContent,
        likesCount: likesCount,
        title: title,
        sound: sound.toDomain(),
        viewsCount: viewsCount,
        iReacted: iReacted,
        iSaved: iSaved,
        shareLink: shareLink,
        sharesCount: sharesCount,
        savesCount: savesCount,
        createdAtString: createdAt,
      );
}
