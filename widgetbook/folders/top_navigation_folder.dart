import 'package:widgetbook/widgetbook.dart';

import '../components/top_navigation/bar_with_avatar_title.dart';
import '../components/top_navigation/bar_with_tag_avatar.dart';

import '../components/top_navigation/bar_with_title_badge.dart';
import '../components/top_navigation/text_bar.dart';
import '../components/top_navigation/three_icons_bar.dart';

class TopNavigationFolder extends WidgetbookFolder {
  TopNavigationFolder()
      : super(
          name: "Top navigation",
          widgets: [
            PicnicBarWithAvatarTitleUsecase(),
            PicnicBarWithTitleBadgeCases(),
            PicnicBarWithTagAvatarUseCase(),
            PicnicTextBarUseCase(),
            PicnicThreeIconsBarUseCase(),
          ],
        );
}
