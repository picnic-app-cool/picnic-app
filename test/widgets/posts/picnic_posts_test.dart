import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_vertical_post.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';

import '../../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_posts",
    widgetBuilder: (context) {
      const footer = "Username";
      return GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'image post',
            child: TestWidgetContainer(
              child: SizedBox(
                width: 160,
                height: 230,
                child: PicnicVerticalPost.image(
                  footer: footer.formattedUsername,
                  avatarUrl: const ImageUrl("https://example_image.png"),
                  views: 100,
                  imageUrl: const ImageUrl(
                    'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/mock-images%2Fpost_drink.webp?alt=media&token=',
                  ),
                  onTapView: () {},
                  hideAuthorAvatar: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'text post',
            child: TestWidgetContainer(
              child: SizedBox(
                width: 160,
                height: 230,
                child: PicnicVerticalPost.text(
                  avatarUrl: const ImageUrl("https://example_image.png"),
                  footer: footer.formattedUsername,
                  views: 100,
                  text: "That is a text to show inside the post",
                  gradient: const LinearGradient(
                    colors: [
                      Color(0XFF93DF78),
                      Color(0XFF61DA7C),
                      Color(0XFFA4DA7B),
                    ],
                  ),
                  onTapView: () {},
                  hideAuthorAvatar: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'poll post',
            child: TestWidgetContainer(
              child: SizedBox(
                width: 160,
                height: 230,
                child: PicnicVerticalPost.poll(
                  avatarUrl: const ImageUrl("https://example_image.png"),
                  footer: footer.formattedUsername,
                  views: 100,
                  leftImageUrl: const ImageUrl("https://example_image.png"),
                  rightImageUrl: const ImageUrl(
                    "https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/mock-images%2Fpost_drink.webp?alt=media&token=",
                  ),
                  onTapView: () {},
                  hideAuthorAvatar: false,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
