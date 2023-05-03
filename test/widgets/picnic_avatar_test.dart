import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/utils/defer_pointer/defer_pointer.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_avatar",
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 2,
      children: [
        GoldenTestScenario(
          name: "crowned",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              isCrowned: true,
              borderColor: PicnicTheme.of(context).colors.green,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "crowned + follow",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              isCrowned: true,
              iFollow: false,
              borderColor: PicnicTheme.of(context).colors.green,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "crowned + follow + shadow",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              isCrowned: true,
              showShadow: true,
              iFollow: false,
              borderColor: PicnicTheme.of(context).colors.green,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "everything",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              isCrowned: true,
              showShadow: true,
              iFollow: false,
              backgroundColor: Colors.lightGreenAccent,
              borderImage: ImageUrl(
                Assets.images.watermelonSeeds.path,
              ),
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "everything + small",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              isCrowned: true,
              showShadow: true,
              size: 50,
              iFollow: false,
              backgroundColor: Colors.lightGreenAccent,
              borderColor: PicnicTheme.of(context).colors.green,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "everything + large",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              isCrowned: true,
              showShadow: true,
              size: 150,
              iFollow: false,
              backgroundColor: Colors.lightGreenAccent,
              borderColor: PicnicTheme.of(context).colors.green,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "shadow + background",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              showShadow: true,
              backgroundColor: Colors.lightGreenAccent,
              borderColor: PicnicTheme.of(context).colors.green,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "no additions",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "verified default",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              isVerified: true,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
            ),
          ),
        ),
        GoldenTestScenario(
          name: "circle verified",
          child: _AvatarTestWidgetContainer(
            child: PicnicAvatar(
              isVerified: true,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.picnicLogo.path),
              ),
              verificationBadgeImage: ImageUrl(Assets.images.circleBadge.path),
            ),
          ),
        )
      ],
    ),
  );
}

class _AvatarTestWidgetContainer extends StatelessWidget {
  const _AvatarTestWidgetContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: DeferredPointerHandler(
        child: TestWidgetContainer(
          child: child,
        ),
      ),
    );
  }
}
