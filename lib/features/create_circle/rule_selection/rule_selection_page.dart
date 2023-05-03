// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/widgets/decorated_sheet.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presentation_model.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presenter.dart';
import 'package:picnic_app/features/create_circle/widgets/rule_decision_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_background.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class RuleSelectionPage extends StatefulWidget with HasPresenter<RuleSelectionPresenter> {
  const RuleSelectionPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final RuleSelectionPresenter presenter;

  @override
  State<RuleSelectionPage> createState() => _RuleSelectionPageState();
}

class _RuleSelectionPageState extends State<RuleSelectionPage>
    with PresenterStateMixin<RuleSelectionViewModel, RuleSelectionPresenter, RuleSelectionPage> {
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
                      ImageUrl(Assets.images.ruleBook.path),
                    ),
                  ),
                  title: appLocalizations.circleRulesTitle,
                  description: appLocalizations.circleRulesDescription,
                ),
                DecoratedSheet(
                  onTap: () => presenter.onTapConfirm(),
                  buttonTitle: appLocalizations.confirmSelectionAction,
                  child: stateObserver(
                    builder: (context, state) => RuleDecisionView(
                      rules: state.rules,
                      selectedRule: state.selectedRule,
                      onDecisionChanged: presenter.onDecisionChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
