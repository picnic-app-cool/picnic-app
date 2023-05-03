enum LogInType {
  phone('phone'),
  google('google'),
  apple('apple'),
  discord('discord'),
  username('username');

  final String value;

  const LogInType(this.value);
}
