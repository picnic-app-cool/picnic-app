import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';

class ContentStatsForContent extends Equatable {
  const ContentStatsForContent({
    required this.saves,
    required this.shares,
    required this.comments,
    required this.reactions,
    required this.impressions,
  });

  const ContentStatsForContent.empty()
      : saves = 0,
        shares = 0,
        comments = 0,
        reactions = const <LikeDislikeReaction, int>{
          LikeDislikeReaction.like: 0,
          LikeDislikeReaction.dislike: 0,
        },
        impressions = 0;

  final int saves;

  final int shares;

  final int comments;

  final Map<LikeDislikeReaction, int> reactions;

  final int impressions;

  int get likes => reactions[LikeDislikeReaction.like] ?? 0;

  int get dislikes => reactions[LikeDislikeReaction.dislike] ?? 0;

  @override
  List<Object?> get props => [
        saves,
        shares,
        comments,
        reactions,
        impressions,
      ];

  ContentStatsForContent copyWith({
    int? saves,
    int? shares,
    int? comments,
    Map<LikeDislikeReaction, int>? reactions,
    int? impressions,
  }) {
    return ContentStatsForContent(
      saves: saves ?? this.saves,
      shares: shares ?? this.shares,
      comments: comments ?? this.comments,
      reactions: reactions ?? this.reactions,
      impressions: impressions ?? this.impressions,
    );
  }
}
