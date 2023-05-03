import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_tag_avatar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:widgetbook/widgetbook.dart';

import '../picnic_avatar.dart';

class PicnicBarWithTagAvatarUseCase extends WidgetbookComponent {
  PicnicBarWithTagAvatarUseCase()
      : super(
          name: '$PicnicBarWithTagAvatar',
          useCases: [
            WidgetbookUseCase(
              name: 'Bar with tag avatar',
              builder: (context) {
                final colors = PicnicTheme.of(context).colors;
                return Center(
                  child: Container(
                    color: colors.indigo,
                    child: PicnicBarWithTagAvatar(
                      avatar: _getAvatar(context),
                      title: context.knobs.text(label: 'title', initialValue: 'startups'),
                      viewsCount: context.knobs.options(
                        label: 'Number of Views',
                        options: [
                          const Option(
                            label: 'Thousands',
                            value: 1234,
                          ),
                          const Option(
                            label: 'Millions',
                            value: 12344564,
                          ),
                        ],
                      ),
                      tag: PicnicTag(
                        title: context.knobs.text(label: 'tag', initialValue: 'startups'),
                        backgroundColor: colors.blackAndWhite.withOpacity(0.07),
                        suffixIcon: Image.asset(Assets.images.add.path),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                      onTitleTap: () {},
                    ),
                  ),
                );
              },
            )
          ],
        );

  static PicnicAvatar _getAvatar(BuildContext context) => PicnicAvatarUseCases.getAvatar(context);
}
