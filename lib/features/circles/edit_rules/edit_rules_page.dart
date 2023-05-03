import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presentation_model.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presenter.dart';
import 'package:picnic_app/features/circles/edit_rules/widgets/rule_input.dart';
import 'package:picnic_app/features/circles/edit_rules/widgets/save_button.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class EditRulesPage extends StatefulWidget with HasPresenter<EditRulesPresenter> {
  const EditRulesPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final EditRulesPresenter presenter;

  @override
  State<EditRulesPage> createState() => _EditRulesPageState();
}

class _EditRulesPageState extends State<EditRulesPage>
    with PresenterStateMixin<EditRulesViewModel, EditRulesPresenter, EditRulesPage> {
  static const _padding = EdgeInsets.symmetric(horizontal: 24.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: theme.colors.blackAndWhite.shade100,
        titleText: appLocalizations.editRulesTitle,
      ),
      body: stateObserver(
        builder: (context, state) {
          return Padding(
            padding: _padding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RuleInput(
                    onChangedRule: presenter.onChangedRules,
                    rules: state.rules,
                  ),
                  const Gap(8),
                  SaveButton(
                    onTapSave: presenter.onTapSave,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
