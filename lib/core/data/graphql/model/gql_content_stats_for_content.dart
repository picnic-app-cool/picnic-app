import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/posts/content_stats_for_content.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';

class GqlContentStatsForContent {
  const GqlContentStatsForContent({
    required this.saves,
    required this.shares,
    required this.comments,
    required this.reactions,
    required this.impressions,
  });

  factory GqlContentStatsForContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlContentStatsForContent(
      saves: asT<int>(json, 'saves'),
      shares: asT<int>(json, 'shares'),
      comments: asT<int>(json, 'comments'),
      impressions: asT<int>(json, 'impressions'),
      reactions: asT<Map<String, dynamic>>(json, 'reactions'),
    );
  }

  final int saves;

  final int shares;

  final int comments;

  final Map<String, dynamic> reactions;

  final int impressions;

  ContentStatsForContent toDomain() {
    final reactionsMap = <LikeDislikeReaction, int>{};
    for (final reactionName in reactions.keys) {
      reactionsMap.putIfAbsent(
        LikeDislikeReaction.fromString(reactionName),
        () => reactions[reactionName].toString().toIntOrZero,
      );
    }
    return ContentStatsForContent(
      saves: saves,
      shares: shares,
      comments: comments,
      reactions: reactionsMap,
      impressions: impressions,
    );
  }
}
