import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_presentation_model.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_presenter.dart';
import 'package:picnic_app/features/circles/edit_circle/widgets/discoverability_setting_list.dart';
import 'package:picnic_app/features/circles/edit_circle/widgets/edit_circle_form_section.dart';
import 'package:picnic_app/features/circles/edit_circle/widgets/save_circle_button.dart';
import 'package:picnic_app/features/create_circle/create_circle/widgets/avatar_edit_button.dart';
import 'package:picnic_app/features/create_circle/create_circle/widgets/circle_cover_header.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class EditCirclePage extends StatefulWidget with HasPresenter<EditCirclePresenter> {
  const EditCirclePage({
    super.key,
    required this.presenter,
  });

  @override
  final EditCirclePresenter presenter;

  @override
  State<EditCirclePage> createState() => _EditCirclePageState();
}

class _EditCirclePageState extends State<EditCirclePage>
    with PresenterStateMixin<EditCircleViewModel, EditCirclePresenter, EditCirclePage> {
  static const _contentPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    final _theme = PicnicTheme.of(context);

    final _colors = _theme.colors;
    final _whiteColor = _colors.blackAndWhite.shade100;

    final _styles = _theme.styles;

    return stateObserver(
      builder: (context, state) {
        //disabled on swipe back on ios
        return WillPopScope(
          onWillPop: () async => !state.circleInfoChanged,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: PicnicAppBar(
              backButtonIconColor: state.coverExists ? _whiteColor : null,
              onTapBack: state.isSaveLoading ? null : presenter.onTapBack,
              child: Text(
                appLocalizations.editCircleInfo,
                style: _styles.subtitle30.copyWith(color: state.coverExists ? _whiteColor : null),
              ),
            ),
            body: SafeArea(
              top: false,
              child: AutomaticKeyboardHide(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleCoverHeader(
                        onTapAvatarEdit: presenter.onTapAvatarEdit,
                        emoji: state.emoji,
                        image: state.image,
                        userSelectedNewImage: state.userSelectedNewImage,
                        coverImage: state.coverImage,
                        userSelectedNewCoverImage: state.userSelectedNewCoverImage,
                        contentPadding: _contentPadding,
                        trailingWidget: AvatarEditButton(
                          onTap: presenter.onTapCoverEdit,
                        ),
                      ),
                      const Gap(60),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _contentPadding,
                        ),
                        child: EditCircleFormSection(
                          name: state.name,
                          description: state.description,
                          onChangedCircleName: presenter.onChangedCircleName,
                          onChangedCircleDescription: presenter.onChangedCircleDescription,
                        ),
                      ),
                      const Gap(24),
                      if (state.isPrivateDiscoverableSettingEnabled)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: _contentPadding,
                          ),
                          child: DiscoverabilitySettingList(
                            onChanged: presenter.onChangedCircleVisibility,
                            groupValue: state.visibility,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: SafeArea(
              child: state.isSaveLoading
                  ? const PicnicLoadingIndicator()
                  : SaveCircleButton(
                      onTap: state.saveEnabled ? presenter.onTapSaveCircle : null,
                    ),
            ),
          ),
        );
      },
    );
  }
}
