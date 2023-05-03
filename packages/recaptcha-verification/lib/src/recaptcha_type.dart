enum RecaptchaType {
  android("android"),
  ios("ios"),
  webview("webview");

  const RecaptchaType(this.type);

  final String type;
}
