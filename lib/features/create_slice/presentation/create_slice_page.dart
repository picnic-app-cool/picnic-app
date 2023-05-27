import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_presentation_model.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_presenter.dart';
import 'package:picnic_app/features/create_slice/presentation/widgets/create_slice_form_section.dart';
import 'package:picnic_app/features/create_slice/presentation/widgets/slice_avatar_section.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';
import 'package:picnic_app/ui/widgets/create_button.dart';
import 'package:picnic_app/ui/widgets/picnic_subtitle.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CreateSlicePage extends StatefulWidget with HasPresenter<CreateSlicePresenter> {
  const CreateSlicePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CreateSlicePresenter presenter;

  @override
  State<CreateSlicePage> createState() => _CreateSlicePageState();
}

class _CreateSlicePageState extends State<CreateSlicePage>
    with PresenterStateMixin<CreateSliceViewModel, CreateSlicePresenter, CreateSlicePage> {
  static const _contentPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styleCaption10 = theme.styles.caption10;
    return stateObserver(
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PicnicAppBar(
          backgroundColor: theme.colors.blackAndWhite.shade100,
          child: Column(
            children: [
              Text(state.title, style: theme.styles.body30),
              stateObserver(
                builder: (context, state) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PicnicSubtitle(
                      subtitle: appLocalizations.sliceOf,
                      subtitleStyle: styleCaption10.copyWith(
                        color: theme.colors.blackAndWhite.shade600,
                      ),
                    ),
                    PicnicSubtitle(
                      subtitle: state.circle.name,
                      subtitleStyle: styleCaption10.copyWith(
                        color: theme.colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                      SliceAvatarSection(
                        onTapAvatarEdit: presenter.onTapAvatarEdit,
                        imagePath: state.createSliceForm.imagePath,
                      ),
                      const Gap(18),
                      CreateSliceFormSection(
                        form: state.createSliceForm,
                        onChangedName: presenter.onChangedName,
                        onChangedDescription: presenter.onChangedDescription,
                        onDiscoverableValueChanged: (bool newValue) =>
                            presenter.onDiscoverableStatusChanged(newValue: newValue),
                        onPrivateValueChanged: (bool newValue) => presenter.onPrivateStatusChanged(newValue: newValue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: CreateButton(
          creatingInProgress: state.isCreatingSliceLoading,
          onTap: state.createSliceEnabled ? presenter.onTapConfirmButton : null,
          title: state.actionButtonLabel,
        ),
      ),
    );
  }
}
