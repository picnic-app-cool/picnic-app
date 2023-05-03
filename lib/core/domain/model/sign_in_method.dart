enum SignInMethod {
  unknown(value: 'UNKNOWN'),
  email(value: 'EMAIL'),
  phone(value: 'PHONE');

  final String value;

  const SignInMethod({required this.value});

  static SignInMethod fromString(String value) => SignInMethod.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => SignInMethod.unknown,
      );

  String toJson() {
    return value;
  }
}
