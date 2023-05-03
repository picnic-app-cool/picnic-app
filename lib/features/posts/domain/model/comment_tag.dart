//ignore_for_file: forbidden_import_in_domain

import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

enum CommentTag { creator }

extension CommentTagExtensions on CommentTag {
  String get label {
    switch (this) {
      case CommentTag.creator:
        return appLocalizations.creatorTagLabel;
    }
  }

  Color getColor(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    switch (this) {
      case CommentTag.creator:
        return colors.green.shade600;
    }
  }

  Color getBackgroundColor(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    switch (this) {
      case CommentTag.creator:
        return colors.green.shade200;
    }
  }
}
