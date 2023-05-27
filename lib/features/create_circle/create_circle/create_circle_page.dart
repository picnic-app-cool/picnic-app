// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/edit_circle/widgets/discoverability_setting_list.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_presentation_model.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_presenter.dart';
import 'package:picnic_app/features/create_circle/create_circle/widgets/avatar_edit_button.dart';
import 'package:picnic_app/features/create_circle/create_circle/widgets/circle_cover_header.dart';
import 'package:picnic_app/features/create_circle/create_circle/widgets/create_circle_form_section.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';
import 'package:picnic_app/ui/widgets/create_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CreateCirclePage extends StatefulWidget with HasPresenter<CreateCirclePresenter> {
  const CreateCirclePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CreateCirclePresenter presenter;

  @override
  State<CreateCirclePage> createState() => _CreateCirclePageState();
}

class _CreateCirclePageState extends State<CreateCirclePage>
    with PresenterStateMixin<CreateCircleViewModel, CreateCirclePresenter, CreateCirclePage> {
  static const _contentPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    final _theme = PicnicTheme.of(context);

    final _colors = _theme.colors;
    final _styles = _theme.styles;

    final _whiteColor = _colors.blackAndWhite.shade100;

    return stateObserver(
      builder: (context, state) {
        final image = state.createCircleForm.image;
        final coverImage = state.createCircleForm.coverImage;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: PicnicAppBar(
            backButtonIconColor: state.coverExists ? _whiteColor : null,
            child: Text(
              appLocalizations.createCircleTitle,
              style: _styles.subtitle30.copyWith(color: state.coverExists ? _whiteColor : null),
            ),
          ),
          body: SafeArea(
            top: false,
            child: AutomaticKeyboardHide(
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleCoverHeader(
                        onTapAvatarEdit: presenter.onTapAvatarEdit,
                        emoji: state.createCircleForm.emoji,
                        image: image,
                        userSelectedNewImage: image.isNotEmpty,
                        coverImage: coverImage,
                        userSelectedNewCoverImage: coverImage.isNotEmpty,
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
                        child: CreateCircleFormSection(
                          form: state.createCircleForm,
                          onTapPickGroup: presenter.onTapPickGroup,
                          onTapPickLanguage: presenter.onTapPickLanguage,
                          onChangedName: presenter.onChangedName,
                          onChangedDescription: presenter.onChangedDescription,
                        ),
                      ),

                      /// to compensate for Floating Action Button
                      const Gap(kToolbarHeight),
                      if (state.isPrivateDiscoverableSettingEnabled)
                        DiscoverabilitySettingList(
                          onChanged: presenter.onChangedCircleVisibility,
                          groupValue: state.visibility,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: CreateButton(
            creatingInProgress: state.isCreatingCircle,
            onTap: state.createCircleEnabled ? presenter.onTapCreateCircle : null,
            title: appLocalizations.nextAction,
          ),
        );
      },
    );
  }
}
