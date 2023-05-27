import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presentation_model.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class ProfilePhotoFormDialogContent extends StatelessWidget {
  const ProfilePhotoFormDialogContent({
    Key? key,
    required this.formType,
    required this.onTapContinue,
    required this.onTapOpenPhotoPicker,
    required this.isLoading,
  }) : super(key: key);

  final ProfilePhotoFormType formType;
  final VoidCallback onTapContinue;
  final bool isLoading;

  final Function() onTapOpenPhotoPicker;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: _PrimaryButton(
                  theme: theme,
                  onTapSelectPhoto: onTapOpenPhotoPicker,
                  formType: formType,
                  onTapContinue: isLoading ? null : onTapContinue,
                ),
              ),
              PicnicLoadingIndicator(isLoading: isLoading),
            ],
          ),
          const Gap(4),
          _SecondaryButton(
            theme: theme,
            formType: formType,
            onTapContinue: onTapContinue,
            onTapSelectPhoto: onTapOpenPhotoPicker,
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    Key? key,
    required this.formType,
    required this.onTapSelectPhoto,
    required this.onTapContinue,
    required this.theme,
  }) : super(key: key);

  final ProfilePhotoFormType formType;
  final Function() onTapSelectPhoto;
  final VoidCallback? onTapContinue;
  final PicnicThemeData theme;

  String get _primaryButtonTitle {
    switch (formType) {
      case ProfilePhotoFormType.beforePhotoSelection:
        return appLocalizations.profilePhotoFormAddPhotoAction;
      case ProfilePhotoFormType.afterPhotoSelection:
        return appLocalizations.continueAction;
    }
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback? onTap;
    Color color;
    switch (formType) {
      case ProfilePhotoFormType.beforePhotoSelection:
        onTap = onTapSelectPhoto;
        color = theme.colors.blue;
        break;
      case ProfilePhotoFormType.afterPhotoSelection:
        onTap = onTapContinue;
        color = theme.colors.blue;
    }

    return PicnicButton(
      onTap: onTap,
      color: color,
      title: _primaryButtonTitle,
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    Key? key,
    required this.formType,
    required this.onTapContinue,
    required this.onTapSelectPhoto,
    required this.theme,
  }) : super(key: key);

  final ProfilePhotoFormType formType;
  final VoidCallback onTapContinue;

  final Function() onTapSelectPhoto;
  final PicnicThemeData theme;

  String get _secondaryButtonTitle {
    switch (formType) {
      case ProfilePhotoFormType.beforePhotoSelection:
        return appLocalizations.profilePhotoFormSkipAction;
      case ProfilePhotoFormType.afterPhotoSelection:
        return appLocalizations.profilePhotoFormChangePhotoAction;
    }
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback onTap;
    switch (formType) {
      case ProfilePhotoFormType.beforePhotoSelection:
        onTap = onTapContinue;
        break;
      case ProfilePhotoFormType.afterPhotoSelection:
        onTap = onTapSelectPhoto;
    }

    return PicnicTextButton(
      onTap: onTap,
      label: _secondaryButtonTitle,
      labelStyle: theme.styles.body20.copyWith(
        color: theme.colors.blackAndWhite.shade600,
      ),
    );
  }
}
