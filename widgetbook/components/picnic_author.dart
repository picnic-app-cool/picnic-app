import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_dynamic_author.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicAuthorUseCase extends WidgetbookComponent {
  PicnicAuthorUseCase()
      : super(
          name: "$PicnicDynamicAuthor",
          isExpanded: true,
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Author Use Cases",
              builder: (context) => Container(
                color: Colors.teal,
                child: PicnicDynamicAuthor(
                  onAuthorUsernameTap: () {},
                  authorUsername: context.knobs.text(
                    label: 'User ID',
                    initialValue: 'payamdiliri',
                  ),
                  avatar: PicnicAvatar(
                    size: 32,
                    backgroundColor: PicnicTheme.of(context).colors.lightBlue.shade300,
                    imageSource: PicnicImageSource.emoji(Constants.hugEmoji),
                  ),
                  comment: context.knobs.options(
                    label: 'Comment',
                    options: const [
                      Option(
                        label: 'Comment',
                        value: '🍹 Saved & shared it!! 🍹',
                      ),
                      Option(
                        label: 'No comment',
                        value: null,
                      ),
                    ],
                  ),
                  viewsCount: context.knobs.options(
                    label: 'Number of Views',
                    options: [
                      const Option(
                        label: 'Thousands',
                        value: 3586,
                      ),
                      const Option(
                        label: 'Millions',
                        value: 12344564,
                      ),
                    ],
                  ),
                  circleName: '',
                ),
              ),
            ),
          ],
        );
}
