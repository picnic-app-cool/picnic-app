// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/widgets/decorated_sheet.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presentation_model.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presenter.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/widgets/rules_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_background.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleCreationRulesPage extends StatefulWidget with HasPresenter<CircleCreationRulesPresenter> {
  const CircleCreationRulesPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleCreationRulesPresenter presenter;

  @override
  State<CircleCreationRulesPage> createState() => _CircleCreationRulesPageState();
}

class _CircleCreationRulesPageState extends State<CircleCreationRulesPage>
    with PresenterStateMixin<CircleCreationRulesViewModel, CircleCreationRulesPresenter, CircleCreationRulesPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return Scaffold(
      body: Stack(
        children: [
          const PicnicBackground(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                PicnicDialog(
                  image: PicnicAvatar(
                    backgroundColor: blackAndWhite.shade300,
                    imageSource: PicnicImageSource.asset(
                      ImageUrl(Assets.images.acorn.path),
                    ),
                  ),
                  title: appLocalizations.seedDialogTitle,
                  description: appLocalizations.seedDialogDescription,
                ),
                DecoratedSheet(
                  onTap: presenter.onTapGo,
                  buttonTitle: appLocalizations.letsGoAction,
                  child: const RulesList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
