// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presenter.dart';
import 'package:picnic_app/features/circles/widgets/mod_sheet_title.dart';
import 'package:picnic_app/features/circles/widgets/mod_user_confirm_button.dart';
import 'package:picnic_app/features/circles/widgets/mod_user_list_tile.dart';
import 'package:picnic_app/features/circles/widgets/picnic_single_choice_selector.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class BanUserPage extends StatefulWidget with HasPresenter<BanUserPresenter> {
  const BanUserPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final BanUserPresenter presenter;

  @override
  State<BanUserPage> createState() => _BanUserPageState();
}

class _BanUserPageState extends State<BanUserPage>
    with PresenterStateMixin<BanUserViewModel, BanUserPresenter, BanUserPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ModSheetTitle(title: appLocalizations.banUserLabel),
          ModUserListTile(user: state.user),
          const Gap(8),
          stateObserver(
            builder: (context, state) {
              return PicnicSingleChoiceSelector(
                choices: state.choices.map((it) => it.toSingleChoice()).toList(),
                onTapChoice: (choice) => presenter.onTapChoice(choice.value),
                selectedChoice: state.selectedBanType.toSingleChoice(),
              );
            },
          ),
          const Gap(16),
          ModUserConfirmButton(
            onTap: presenter.onTapConfirm,
            title: appLocalizations.confirmAction,
          ),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.closeAction,
              onTap: presenter.onTapClose,
            ),
          ),
        ],
      ),
    );
  }
}
