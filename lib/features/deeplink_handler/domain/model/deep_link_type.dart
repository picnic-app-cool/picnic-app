enum DeepLinkType {
  profile('profile'),
  chat('chat'),
  circle('circle'),
  post('post'),
  userSeeds('user_seeds'),
  election('election'),
  general('');

  final String value;

  const DeepLinkType(this.value);

  static DeepLinkType fromString(String value) => DeepLinkType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => DeepLinkType.general,
      );
}
