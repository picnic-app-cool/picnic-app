// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/image_picker/image_picker_presentation_model.dart';
import 'package:picnic_app/features/image_picker/image_picker_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ImagePickerPage extends StatefulWidget with HasPresenter<ImagePickerPresenter> {
  const ImagePickerPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ImagePickerPresenter presenter;

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage>
    with PresenterStateMixin<ImagePickerViewModel, ImagePickerPresenter, ImagePickerPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final lightBlue = theme.colors.lightBlue;
    final textStyleBody20 = theme.styles.body20;

    final blackWhiteShade700 = theme.colors.blackAndWhite.shade700;
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      title: Text(
        appLocalizations.imagePickerAlertTitle,
        style: theme.styles.title20.copyWith(color: lightBlue), //
      ),
      children: state.availableOptions
          .map(
            (type) => Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                onTap: () => presenter.onTapItem(type),
                title: Text(
                  type.label,
                  style: textStyleBody20,
                ),
                leading: Image.asset(
                  type.icon,
                  color: blackWhiteShade700,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
