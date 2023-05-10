enum LikeDislikeReaction {
  like(':heart:'),
  dislike(':thumbsdown:'),
  noReaction('');

  final String value;

  const LikeDislikeReaction(this.value);

  static LikeDislikeReaction fromString(String value) => LikeDislikeReaction.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => LikeDislikeReaction.noReaction,
      );
}
