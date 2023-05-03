import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicAvatarUseCases extends WidgetbookComponent {
  PicnicAvatarUseCases()
      : super(
          name: "$PicnicAvatar",
          useCases: [
            WidgetbookUseCase(
              name: "Avatar User Cases",
              builder: (context) {
                return Container(
                  color: Colors.lightBlueAccent,
                  child: Center(
                    child: getAvatar(context),
                  ),
                );
              },
            ),
          ],
        );

  static PicnicAvatar getAvatar(BuildContext context) {
    final themeColors = PicnicTheme.of(context).colors;
    final colors = [
      Option(
        label: "Pink",
        value: themeColors.pink,
      ),
      Option(
        label: "Dark Blue",
        value: themeColors.blue,
      ),
      Option(
        label: "Teal Green",
        value: themeColors.teal,
      ),
      Option(
        label: "Yellow",
        value: themeColors.yellow,
      ),
      Option(
        label: "Black",
        value: themeColors.blackAndWhite,
      ),
    ];

    return PicnicAvatar(
      size: context.knobs.options(
        label: 'Size',
        options: [
          const Option(label: '100', value: 100),
          const Option(label: '200', value: 200),
          const Option(label: '150', value: 150),
        ],
      ),
      backgroundColor: context.knobs.options(
        label: 'Background Color',
        options: colors,
      ),
      backgroundImage: context.knobs.options(
        label: 'Background Image',
        options: [
          const Option(label: 'Empty', value: ImageUrl.empty()),
          Option(label: 'Purple Avatar', value: ImageUrl(Assets.images.avatar.path)),
          Option(label: 'Picnic Watermelon', value: ImageUrl(Assets.images.watermelonSkin.path)),
        ],
      ),
      borderImage: context.knobs.options(
        label: 'Border Image',
        options: [
          const Option(label: 'Empty', value: ImageUrl.empty()),
          Option(
            label: 'Watermelon Seeds',
            value: ImageUrl(Assets.images.watermelonSeeds.path),
          ),
          Option(
            label: 'Watermelon Skin',
            value: ImageUrl(Assets.images.watermelonSkin.path),
          ),
        ],
      ),
      borderColor: context.knobs.options(
        label: 'Border Color',
        options: [
          ...colors,
          const Option(
            label: "No border",
            value: null,
          ),
        ],
      ),
      isCrowned: context.knobs.options(
        label: 'Crowned?',
        options: [
          const Option(label: 'Yes', value: true),
          const Option(label: 'No', value: false),
        ],
      ),
      iFollow: context.knobs.options(
        label: 'Followed?',
        options: [
          const Option(label: 'Yes', value: true),
          const Option(label: 'No', value: false),
        ],
      ),
      boxFit: context.knobs.options(
        label: 'Fit?',
        options: [
          const Option(label: 'Cover', value: PicnicAvatarChildBoxFit.cover),
          const Option(label: 'Fit', value: PicnicAvatarChildBoxFit.fit),
        ],
      ),
      imageSource: context.knobs.options(
        label: 'Child',
        options: [
          Option(
            label: 'Watermelon',
            value: PicnicImageSource.asset(
              ImageUrl(Assets.images.picnicLogo.path),
            ),
          ),
          Option(
            label: 'Calendar',
            value: PicnicImageSource.asset(
              ImageUrl(Assets.images.calendar.path),
            ),
          ),
          Option(
            label: 'Picnic Watermelon',
            value: PicnicImageSource.asset(
              ImageUrl(Assets.images.watermelonSkin.path),
            ),
          ),
          Option(
            label: 'Picnic Avatar',
            value: PicnicImageSource.asset(
              ImageUrl(Assets.images.avatar.path),
            ),
          ),
        ],
      ),
    );
  }
}
