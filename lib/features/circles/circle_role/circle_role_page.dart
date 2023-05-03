import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presenter.dart';
import 'package:picnic_app/features/circles/circle_role/widgets/circle_role_form_section.dart';
import 'package:picnic_app/features/circles/circle_role/widgets/circle_role_top_section.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';

class CircleRolePage extends StatefulWidget with HasPresenter<CircleRolePresenter> {
  const CircleRolePage({
    super.key,
    required this.presenter,
  });

  @override
  final CircleRolePresenter presenter;

  @override
  State<CircleRolePage> createState() => _CircleRolePageState();
}

class _CircleRolePageState extends State<CircleRolePage>
    with PresenterStateMixin<CircleRoleViewModel, CircleRolePresenter, CircleRolePage> {
  static const _contentPadding = 16.0;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) {
        final roleColor = state.circleRole.formattedColor;
        _textController.text = roleColor.name;

        return WillPopScope(
          onWillPop: () async => !state.roleInfoChanged,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PicnicAppBar(
              onTapBack: presenter.onTapBack,
              titleText: _dialogTitle(state),
            ),
            body: SafeArea(
              child: AutomaticKeyboardHide(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _contentPadding,
                  ),
                  child: SizedBox.expand(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CircleRoleTopSection(
                            onTapEditEmoji: presenter.onTapEditEmoji,
                            emoji: state.circleRole.emoji,
                          ),
                          const Gap(24),
                          CircleRoleFormSection(
                            onTapConfirm: state.confirmButtonEnabled ? presenter.onTapConfirm : null,
                            circleRole: state.circleRole,
                            onChangedName: presenter.onNameUpdated,
                            onPostContentPermissionChanged: (bool newValue) => presenter.onPostContentPermissionChanged(
                              newValue: newValue,
                            ),
                            onSendMessagesPermissionChanged: (bool newValue) =>
                                presenter.onSendMessagesPermissionChanged(
                              newValue: newValue,
                            ),
                            onEmbedLinksPermissionChanged: (bool newValue) => presenter.onEmbedLinksPermissionChanged(
                              newValue: newValue,
                            ),
                            onAttachFilesPermissionChanged: (bool newValue) => presenter.onAttachFilesPermissionChanged(
                              newValue: newValue,
                            ),
                            onManageCirclePermissionChanged: (bool newValue) =>
                                presenter.onManageCirclePermissionChanged(
                              newValue: newValue,
                            ),
                            onManageRolesPermissionChanged: (bool newValue) => presenter.onManageRolesPermissionChanged(
                              newValue: newValue,
                            ),
                            selectedColor: roleColor,
                            onTapColorPicker: presenter.onTapColorPicker,
                            textController: _textController,
                            onManageUsersPermissionChanged: (bool newValue) => presenter.onManageUsersPermissionChanged(
                              newValue: newValue,
                            ),
                            onManageMessagesPermissionChanged: (bool value) =>
                                presenter.onManageMessagesPermissionChanged(
                              newValue: value,
                            ),
                            onManageReportsPermissionChanged: (bool value) =>
                                presenter.onManageReportsPermissionChanged(
                              newValue: value,
                            ),
                            onManageCommentsPermissionChanged: (bool value) =>
                                presenter.onManageCommentsPermissionChanged(
                              newValue: value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _dialogTitle(CircleRoleViewModel state) {
    switch (state.formType) {
      case CircleRoleFormType.createCircleRole:
        return appLocalizations.create_role_page_title;
      case CircleRoleFormType.editCircleRole:
        return appLocalizations.editRole(state.circleRole.name);
    }
  }
}
