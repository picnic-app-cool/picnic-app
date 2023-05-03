enum CircleConfigType {
  chatting('Chatting'),
  comments('Comments'),
  text('ThoughtPosts'),
  video('VideoPosts'),
  photo('PhotoPosts'),
  link('LinkPosts'),
  poll('PollPosts'),
  visibility('Visibility'),
  none('None');

  final String value;

  const CircleConfigType(this.value);

  static CircleConfigType fromString(String value) => CircleConfigType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => CircleConfigType.none,
      );
}
