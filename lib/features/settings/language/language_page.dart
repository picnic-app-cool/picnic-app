// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/language/language_presentation_model.dart';
import 'package:picnic_app/features/settings/language/language_presenter.dart';
import 'package:picnic_app/features/settings/language/widgets/language_select_button.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/picnic_app.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class LanguagePage extends StatefulWidget with HasPresenter<LanguagePresenter> {
  const LanguagePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final LanguagePresenter presenter;

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage>
    with PresenterStateMixin<LanguageViewModel, LanguagePresenter, LanguagePage> {
  static const _paddingHorizontal = EdgeInsets.symmetric(horizontal: 24.0);

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          backgroundColor: theme.colors.blackAndWhite.shade100,
          titleText: appLocalizations.languageAppBarTitle,
          actions: [
            PicnicContainerIconButton(
              iconPath: Assets.images.infoSquareOutlined.path,
              onTap: () => presenter.onTapShowInfo(),
            ),
          ],
        ),
        body: Column(
          children: [
            if (state.showLanguageSearchBar)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  0,
                  24,
                  8,
                ),
                child: PicnicSoftSearchBar(
                  onChanged: presenter.searchChanged,
                  hintText: appLocalizations.languageSearchInputHint,
                ),
              ),
            Expanded(
              child: stateObserver(
                builder: (context, state) => ListView.separated(
                  separatorBuilder: _listItemSpaces,
                  itemCount: state.languages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final language = state.languages[index];
                    return Padding(
                      padding: _paddingHorizontal,
                      child: LanguageSelectButton(
                        language: language,
                        isSelected: language.code == state.selectedLanguage,
                        onTapSelectLanguage: (language) => _onTapSelectLanguage(language),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItemSpaces(BuildContext context, int index) {
    return const Gap(8);
  }

  void _onTapSelectLanguage(Language language) {
    PicnicApp.of(context)?.setLocale(Locale(language.code));
    presenter.onTapSelectLanguage(language);
  }
}
