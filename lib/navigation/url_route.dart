import 'package:url_launcher/url_launcher.dart';

mixin UrlRoute {
  Future<void> openUrl(String url) {
    return launchUrl(Uri.parse(url));
  }
}
