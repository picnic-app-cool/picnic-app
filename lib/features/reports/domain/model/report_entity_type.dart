enum ReportEntityType {
  circle('CIRCLE'),
  chat('CHAT'),
  post('POST'),
  comment('COMMENT'),
  user('USER'),
  collection('COLLECTION'),
  slice('SLICE'),
  message('MESSAGE'),
  all('ALL'),
  spam('SPAM'),
  text('TEXT'),
  image('IMAGE'),
  video('VIDEO'),
  link('LINK'),
  poll('POLL'),
  unknown('');

  const ReportEntityType(this.stringVal);

  final String stringVal;

  static ReportEntityType fromString(String value) => ReportEntityType.values.firstWhere(
        (it) => it.stringVal.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => ReportEntityType.unknown,
      );
}
