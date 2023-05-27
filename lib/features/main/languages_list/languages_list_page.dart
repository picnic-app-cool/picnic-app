import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_presentation_model.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_presenter.dart';
import 'package:picnic_app/features/main/languages_list/widgets/languages_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class LanguagesListPage extends StatefulWidget with HasPresenter<LanguagesListPresenter> {
  const LanguagesListPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final LanguagesListPresenter presenter;

  @override
  State<LanguagesListPage> createState() => _LanguagesListPageState();
}

class _LanguagesListPageState extends State<LanguagesListPage>
    with PresenterStateMixin<LanguagesListViewModel, LanguagesListPresenter, LanguagesListPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return stateObserver(
      builder: (context, state) {
        if (state.isLoading) {
          return const PicnicLoadingIndicator();
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.selectPrimaryLanguageTitle,
                  style: theme.styles.subtitle40,
                ),
                const Gap(12),
                LanguagesListView(
                  onLanguageSelected: presenter.onLanguageSelected,
                  selectedLanguage: state.selectedLanguage,
                  languages: state.languages,
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: PicnicButton(
                    title: appLocalizations.confirmAction,
                    onTap: presenter.onTapConfirm,
                  ),
                ),
                Center(
                  child: PicnicTextButton(
                    label: appLocalizations.noAction,
                    onTap: presenter.onTapNo,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
