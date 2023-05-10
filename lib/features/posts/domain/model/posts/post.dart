import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/content_stats_for_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post_context.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.author,
    required this.circle,
    required this.content,
    required this.title,
    required this.sound,
    required this.shareLink,
    required this.createdAtString,
    required this.context,
    required this.contentStats,
  });

  const Post.empty()
      : id = const Id(''),
        author = const BasicPublicProfile.empty(),
        circle = const BasicCircle.empty(),
        content = const TextPostContent.empty(),
        title = '',
        sound = const Sound.empty(),
        shareLink = '',
        createdAtString = '',
        context = const PostContext.empty(),
        contentStats = const ContentStatsForContent.empty();

  final BasicPublicProfile author;

  final BasicCircle circle;

  final PostContent content;

  final Id id;

  final String title;

  final Sound sound;

  final String shareLink;

  final String createdAtString;

  final PostContext context;

  final ContentStatsForContent contentStats;

  PostType get type => content.type;

  PostOverlayTheme get overlayTheme => type.overlayTheme;

  bool get reactButtonsVertical => type.reactButtonsVertical;

  DateTime? get createdAt => DateTime.tryParse(createdAtString)?.toLocal();

  bool get iLiked => context.reaction == LikeDislikeReaction.like;

  bool get iDisliked => context.reaction == LikeDislikeReaction.dislike;

  @override
  List<Object?> get props => [
        author,
        circle,
        content,
        id,
        title,
        sound,
        shareLink,
        type,
        createdAtString,
        context,
        contentStats,
      ];

  //ignore: maximum-nesting
  Post byLikingPost() {
    if (iLiked) {
      return this;
    } else {
      var updatedReactions = Map.of(contentStats.reactions);
      updatedReactions[LikeDislikeReaction.dislike] = _getUpdateDislikesCount();
      final likesCount = contentStats.reactions[LikeDislikeReaction.like] ?? 0;
      updatedReactions[LikeDislikeReaction.like] = likesCount + 1;
      return copyWith(
        contentStats: contentStats.copyWith(
          reactions: updatedReactions,
        ),
        context: context.copyWith(reaction: LikeDislikeReaction.like),
      );
    }
  }

  //ignore: maximum-nesting-level
  Post byDislikingPost() {
    if (iDisliked) {
      return this;
    } else {
      var updatedReactions = Map.of(contentStats.reactions);
      updatedReactions[LikeDislikeReaction.like] = _getUpdateLikeCount();
      final dislikeCount = contentStats.reactions[LikeDislikeReaction.dislike] ?? 0;
      updatedReactions[LikeDislikeReaction.dislike] = dislikeCount + 1;
      return copyWith(
        contentStats: contentStats.copyWith(
          reactions: updatedReactions,
        ),
        context: context.copyWith(reaction: LikeDislikeReaction.dislike),
      );
    }
  }

  Post byUnReactingToPost() {
    final previouslyLiked = context.reaction == LikeDislikeReaction.like;
    final previouslyDisliked = context.reaction == LikeDislikeReaction.dislike;
    var updatedReactions = Map.of(contentStats.reactions);
    if (previouslyLiked) {
      final likesCount = contentStats.reactions[LikeDislikeReaction.like] ?? 0;
      if (likesCount != 0) {
        updatedReactions[LikeDislikeReaction.like] = likesCount - 1;
      }
    }
    if (previouslyDisliked) {
      final dislikeCount = contentStats.reactions[LikeDislikeReaction.dislike] ?? 0;
      if (dislikeCount != 0) {
        updatedReactions[LikeDislikeReaction.dislike] = dislikeCount - 1;
      }
    }
    return copyWith(
      contentStats: contentStats.copyWith(
        reactions: updatedReactions,
      ),
      context: context.copyWith(reaction: LikeDislikeReaction.noReaction),
    );
  }

  Post byUpdatingSavedStatus({required bool iSaved}) => copyWith(
        context: context.copyWith(saved: iSaved),
        contentStats: contentStats.copyWith(
          saves: context.saved == iSaved
              ? contentStats.saves
              : iSaved
                  ? contentStats.saves + 1
                  : contentStats.saves - 1,
        ),
      );

  Post byIncrementingShareCount() => copyWith(
        contentStats: contentStats.copyWith(shares: contentStats.shares + 1),
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
    PostContent? content,
    Id? id,
    String? postedAtString,
    String? title,
    Sound? sound,
    String? shareLink,
    String? createdAtString,
    PostContext? context,
    ContentStatsForContent? contentStats,
  }) {
    return Post(
      author: author ?? this.author,
      circle: circle ?? this.circle,
      content: content ?? this.content,
      id: id ?? this.id,
      title: title ?? this.title,
      sound: sound ?? this.sound,
      shareLink: shareLink ?? this.shareLink,
      createdAtString: createdAtString ?? this.createdAtString,
      context: context ?? this.context,
      contentStats: contentStats ?? this.contentStats,
    );
  }

  int _getUpdateDislikesCount() {
    final dislikeCount = contentStats.reactions[LikeDislikeReaction.dislike] ?? 0;
    if (iDisliked && dislikeCount != 0) {
      return dislikeCount - 1;
    }
    return dislikeCount;
  }

  int _getUpdateLikeCount() {
    final likesCount = contentStats.reactions[LikeDislikeReaction.like] ?? 0;
    if (iLiked && likesCount != 0) {
      return likesCount - 1;
    }
    return likesCount;
  }
}

extension PostHelpers on Post {
  String get circleTag => circle.name;
}
