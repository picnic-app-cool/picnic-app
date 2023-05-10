import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post_context.dart';

class GqlPostContext {
  const GqlPostContext({
    required this.reaction,
    required this.saved,
    required this.pollAnswerId,
  });

  factory GqlPostContext.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlPostContext(
      reaction: asT<String>(json, 'reaction'),
      saved: asT<bool>(json, 'saved'),
      pollAnswerId: asT<String>(json, 'pollAnswerId'),
    );
  }

  final String? reaction;

  final bool saved;

  final String pollAnswerId;

  PostContext toDomain() => PostContext(
        pollAnswerId: Id(pollAnswerId),
        saved: saved,
        reaction: LikeDislikeReaction.fromString(reaction ?? ''),
      );
}
