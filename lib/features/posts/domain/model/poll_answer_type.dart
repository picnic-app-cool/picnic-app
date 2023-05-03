/// type of the answer in a poll post
enum PollAnswerType {
  /// v1 only supports images"
  image;

  String get stringVal {
    switch (this) {
      case PollAnswerType.image:
        return 'IMAGE';
    }
  }
}
