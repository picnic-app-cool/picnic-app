import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_avatar_title.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../constants/widgetbook_constants.dart';
import '../picnic_avatar.dart';

class PicnicBarWithAvatarTitleUsecase extends WidgetbookComponent {
  PicnicBarWithAvatarTitleUsecase()
      : super(
          name: '$PicnicBarWithAvatarTitle',
          useCases: [
            WidgetbookUseCase(
              name: 'Bar with avatar and title',
              builder: (context) {
                return PicnicBarWithAvatarTitle(
                  iconPathLeft: context.knobs.options(
                    label: 'left icon',
                    options: WidgetBookConstants.topIconsList,
                  ),
                  onTapLeft: () {},
                  iconTintColor: context.knobs.options(
                    label: "icon tint color",
                    options: WidgetBookConstants.colorOptionsNullable,
                  ),
                  avatar: _getAvatar(context),
                  suffix: _getSuffix(context),
                );
              },
            ),
            WidgetbookUseCase(
              name: 'Bar with avatar and title and subtitle',
              builder: (context) {
                return PicnicBarWithAvatarTitle(
                  iconPathLeft: context.knobs.options(
                    label: 'left icon',
                    options: WidgetBookConstants.topIconsList,
                  ),
                  onTapLeft: () {},
                  iconTintColor: context.knobs.options(
                    label: "icon tint color",
                    options: WidgetBookConstants.colorOptionsNullable,
                  ),
                  avatar: _getAvatar(context),
                  suffix: _getSuffix(context),
                );
              },
            ),
          ],
        );

  static PicnicAvatar _getAvatar(BuildContext context) => PicnicAvatarUseCases.getAvatar(context);

  static Widget? _getSuffix(BuildContext context) => context.knobs.options(
        label: "suffix",
        options: [
          const Option(label: 'None', value: null),
          Option(
            label: 'Icon button',
            value: PicnicContainerIconButton(
              iconPath: Assets.images.bell.path,
              onTap: () {},
            ),
          ),
        ],
      );
}
