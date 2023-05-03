import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.author,
    required this.circle,
    required this.commentsCount,
    required this.content,
    required this.likesCount,
    required this.title,
    required this.sound,
    required this.viewsCount,
    required this.sharesCount,
    required this.savesCount,
    required this.iReacted,
    required this.iSaved,
    required this.shareLink,
    required this.createdAtString,
  });

  const Post.empty()
      : id = const Id(''),
        author = const BasicPublicProfile.empty(),
        circle = const BasicCircle.empty(),
        commentsCount = 0,
        content = const TextPostContent.empty(),
        likesCount = 0,
        title = '',
        sound = const Sound.empty(),
        viewsCount = 0,
        sharesCount = 0,
        savesCount = 0,
        iReacted = false,
        iSaved = false,
        shareLink = '',
        createdAtString = '';

  final BasicPublicProfile author;

  final BasicCircle circle;

  final int commentsCount;

  final PostContent content;

  final Id id;

  final int likesCount;

  final String title;

  final int viewsCount;

  final int sharesCount;

  final int savesCount;

  final Sound sound;

  final bool iReacted;

  final bool iSaved;

  final String shareLink;

  final String createdAtString;

  PostType get type => content.type;

  PostOverlayTheme get overlayTheme => type.overlayTheme;

  DateTime? get createdAt => DateTime.tryParse(createdAtString)?.toLocal();

  @override
  List<Object?> get props => [
        author,
        circle,
        commentsCount,
        content,
        id,
        likesCount,
        title,
        viewsCount,
        savesCount,
        sharesCount,
        sound,
        iReacted,
        iSaved,
        shareLink,
        type,
        createdAtString,
      ];

  Post byUpdatingLikeStatus({required bool iReacted}) => copyWith(
        iReacted: iReacted,
        likesCount: iReacted == this.iReacted
            ? likesCount
            : iReacted
                ? likesCount + 1
                : likesCount - 1,
      );

  Post byUpdatingSavedStatus({required bool iSaved}) => copyWith(
        iSaved: iSaved,
        savesCount: iSaved == this.iSaved
            ? savesCount
            : iSaved
                ? savesCount + 1
                : savesCount - 1,
      );

  Post byIncrementingShareCount() => copyWith(
        sharesCount: sharesCount + 1,
      );

  Post byUpdatingAuthorWithFollow({required bool follow}) {
    return copyWith(
      author: author.copyWith(iFollow: follow),
    );
  }

  Post byUpdatingJoinedStatus({required bool iJoined}) {
    return copyWith(
      circle: circle.copyWith(iJoined: iJoined),
    );
  }

  Post copyWith({
    BasicPublicProfile? author,
    BasicCircle? circle,
    int? commentsCount,
    PostContent? content,
    Id? id,
    int? likesCount,
    String? postedAtString,
    String? title,
    int? viewsCount,
    int? sharesCount,
    int? savesCount,
    Sound? sound,
    bool? iReacted,
    bool? iSaved,
    String? shareLink,
    String? createdAtString,
  }) {
    return Post(
      author: author ?? this.author,
      circle: circle ?? this.circle,
      commentsCount: commentsCount ?? this.commentsCount,
      content: content ?? this.content,
      id: id ?? this.id,
      likesCount: likesCount ?? this.likesCount,
      title: title ?? this.title,
      viewsCount: viewsCount ?? this.viewsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      savesCount: savesCount ?? this.savesCount,
      sound: sound ?? this.sound,
      iReacted: iReacted ?? this.iReacted,
      iSaved: iSaved ?? this.iSaved,
      shareLink: shareLink ?? this.shareLink,
      createdAtString: createdAtString ?? this.createdAtString,
    );
  }
}

extension PostHelpers on Post {
  String get circleTag => circle.name;
}
