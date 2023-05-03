import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components/animated_endless_rotation.dart';
import 'components/bottom_navigation/picnic_bottom_navigation.dart';
import 'components/picnic_author.dart';
import 'components/picnic_avatar.dart';
import 'components/picnic_badge.dart';
import 'components/picnic_button.dart';
import 'components/picnic_collection_card.dart';
import 'components/picnic_comment_text_input.dart';
import 'components/picnic_dialog.dart';
import 'components/picnic_glitterbomb_alert.dart';
import 'components/picnic_icon_button.dart';
import 'components/picnic_link_post.dart';
import 'components/picnic_list_item.dart';
import 'components/picnic_melons_count_label.dart';
import 'components/picnic_message_offer.dart';
import 'components/picnic_post.dart';
import 'components/picnic_radio_button.dart';
import 'components/picnic_square.dart';
import 'components/picnic_switch.dart';
import 'components/picnic_tab.dart';
import 'components/picnic_tag.dart';
import 'components/picnic_text_button.dart';
import 'components/picnic_text_input.dart';
import 'components/picnic_text_post.dart';
import 'components/picnic_user_profile_stats.dart';
import 'components/poll_post/picnic_poll_post.dart';
import 'folders/buttons_folder.dart';
import 'folders/diagrams_folder.dart';
import 'folders/misc_folder.dart';
import 'folders/posts_folder.dart';
import 'folders/texts_folder.dart';
import 'folders/top_navigation_folder.dart';

class WidgetbookPicnicApp extends StatelessWidget {
  const WidgetbookPicnicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicnicTheme(
      child: Widgetbook.material(
        devices: [Apple.iPhone12, Samsung.s10],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: [
          const Locale('en', ''),
        ],
        categories: [
          WidgetbookCategory(
            name: "Components",
            folders: [
              TopNavigationFolder(),
              ButtonsFolder(),
              MiscFolder(),
              TextsFolder(),
              DiagamsFolder(),
              PostsFolder(),
            ],
            widgets: [
              AnimatedEndlessRotationUseCases(),
              PicnicUserProfileStatsUseCase(),
              PicnicCircleSquareUseCases(),
              PicnicAvatarUseCases(),
              PicnicSwitchUseCases(),
              PicnicListItemUseCases(),
              PicnicTagUseCase(),
              PicnicButtonUseCases(),
              PicnicBadgeUseCase(),
              PicnicTabUseCase(),
              PicnicDialogUseCases(),
              PicnicIconButtonUseCases(),
              PicnicCommentTextInputUseCases(),
              PicnicPostUseCases(),
              PicnicAuthorUseCase(),
              PicnicRadioButtonUseCases(),
              PicnicPollPostUseCases(),
              PicnicAuthorUseCase(),
              PicnicBottomNavigationUseCase(),
              PicnicTextButtonUseCases(),
              PicnicMessageOfferUseCases(),
              PicnicLinkPostUseCases(),
              PicnicTextPostUseCase(),
              PicnicMelonsCountLabelUseCases(),
              PicnicTextInputUseCases(),
              PicnicCollectionCardUseCase(),
              PicnicGlitterbombAlertUseCases(),
            ],
          ),
        ],
        themes: [
          WidgetbookTheme(name: "Light", data: ThemeData.light()),
          WidgetbookTheme(name: "Dark", data: ThemeData.dark()),
        ],
        appInfo: AppInfo(name: "Picnic Widgetbook"),
      ),
    );
  }
}
