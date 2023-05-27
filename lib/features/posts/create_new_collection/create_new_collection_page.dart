import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_presentation_model.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class CreateNewCollectionPage extends StatefulWidget with HasPresenter<CreateNewCollectionPresenter> {
  const CreateNewCollectionPage({
    super.key,
    required this.presenter,
  });

  @override
  final CreateNewCollectionPresenter presenter;

  @override
  State<CreateNewCollectionPage> createState() => _CreateNewCollectionPageState();
}

class _CreateNewCollectionPageState extends State<CreateNewCollectionPage>
    with PresenterStateMixin<CreateNewCollectionViewModel, CreateNewCollectionPresenter, CreateNewCollectionPage> {
  static const _sheetPadding = 20.0;
  static const _sheetBottomPadding = 32.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _sheetPadding,
        _sheetPadding,
        _sheetPadding,
        MediaQuery.of(context).viewInsets.bottom + _sheetBottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            appLocalizations.createANewCollection,
            style: styles.subtitle40,
          ),
          const Gap(20),
          PicnicTextInput(
            hintText: appLocalizations.collectionName,
            onChanged: presenter.onCollectionNameInputChanged,
            padding: 0,
          ),
          const Gap(20),
          PicnicButton(
            onTap: presenter.onTapCreate,
            title: appLocalizations.create,
          ),
          const Gap(8),
          PicnicTextButton(
            onTap: presenter.onTapClose,
            label: appLocalizations.closeAction,
          ),
        ],
      ),
    );
  }
}
