enum DevicePlatform {
  ios('IOS'),
  android('ANDROID'),
  macos('MACOS'),
  windows('WINDOWS'),
  linux('LINUX'),
  other('OTHER');

  const DevicePlatform(this.value);

  final String value;
}
