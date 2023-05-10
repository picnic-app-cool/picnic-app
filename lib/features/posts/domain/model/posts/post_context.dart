import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';

class PostContext extends Equatable {
  const PostContext({
    required this.reaction,
    required this.saved,
    required this.pollAnswerId,
  });

  const PostContext.empty()
      : reaction = LikeDislikeReaction.noReaction,
        saved = false,
        pollAnswerId = const Id('');

  final LikeDislikeReaction reaction;

  final bool saved;

  final Id pollAnswerId;

  @override
  List<Object?> get props => [
        reaction,
        saved,
        pollAnswerId,
      ];

  PostContext copyWith({
    LikeDislikeReaction? reaction,
    bool? saved,
    Id? pollAnswerId,
  }) {
    return PostContext(
      reaction: reaction ?? this.reaction,
      saved: saved ?? this.saved,
      pollAnswerId: pollAnswerId ?? this.pollAnswerId,
    );
  }
}
