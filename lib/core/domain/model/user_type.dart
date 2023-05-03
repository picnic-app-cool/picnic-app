enum UserType {
  contact('CONTACT'),
  picnic('PICNIC');

  final String value;

  const UserType(this.value);

  static UserType fromString(String value) => UserType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => UserType.picnic,
      );
}
