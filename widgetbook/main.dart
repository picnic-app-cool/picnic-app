import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import 'widgetbook_picnic_app.dart';

void main() {
  overrideAppLocalizations(AppLocalizationsEn());

  runApp(
    const PicnicTheme(
      child: WidgetbookPicnicApp(),
    ),
  );
}
