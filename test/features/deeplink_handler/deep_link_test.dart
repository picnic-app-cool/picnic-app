import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_circle.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_post.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_profile.dart';

void main() {
  test("post deeplink url should parse properly", () {
    final link = DeepLink.fromUri(Uri.parse("https://picnic.zone/post/413705da-8e5d-414b-9416-87e207ba6389"));
    expect(link is DeepLinkPost, true);
    expect((link as DeepLinkPost).postId.value, "413705da-8e5d-414b-9416-87e207ba6389");
  });

  test("circle deeplink url should parse properly", () {
    final link = DeepLink.fromUri(Uri.parse("https://picnic.zone/circle/413705da-8e5d-414b-9416-87e207ba6389"));
    expect(link is DeepLinkCircle, true);
    expect((link as DeepLinkCircle).circleId.value, "413705da-8e5d-414b-9416-87e207ba6389");
  });

  test("profile deeplink url should parse properly", () {
    final link = DeepLink.fromUri(Uri.parse("https://picnic.zone/profile/413705da-8e5d-414b-9416-87e207ba6389"));
    expect(link is DeepLinkProfile, true);
    expect((link as DeepLinkProfile).userId.value, "413705da-8e5d-414b-9416-87e207ba6389");
  });
}
