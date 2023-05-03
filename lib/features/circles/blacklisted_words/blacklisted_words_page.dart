import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presentation_model.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presenter.dart';
import 'package:picnic_app/features/circles/blacklisted_words/widgets/word_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class BlacklistedWordsPage extends StatefulWidget with HasPresenter<BlacklistedWordsPresenter> {
  const BlacklistedWordsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final BlacklistedWordsPresenter presenter;

  @override
  State<BlacklistedWordsPage> createState() => _BlacklistedWordsPageState();
}

class _BlacklistedWordsPageState extends State<BlacklistedWordsPage>
    with PresenterStateMixin<BlacklistedWordsViewModel, BlacklistedWordsPresenter, BlacklistedWordsPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = PicnicTheme.of(context);

    final searchBar = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: PicnicSoftSearchBar(
        onChanged: presenter.onSearchTextChanged,
        hintText: appLocalizations.search,
      ),
    );
    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: themeData.colors.blackAndWhite.shade100,
        actions: [
          PicnicContainerIconButton(
            iconPath: Assets.images.add.path,
            onTap: presenter.onTapAddWord,
          ),
        ],
        child: Text(
          appLocalizations.blacklistedWords,
          style: themeData.styles.title20,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (presenter.state.searchBlacklistWordsEnabled) ...[
            searchBar,
            const Gap(8),
          ],
          stateObserver(
            builder: (context, state) => Expanded(
              child: WordList(
                getWords: presenter.getWords,
                words: state.words,
                onTapDeleteWord: presenter.onTapDeleteWord,
                onTapEditWord: presenter.onTapEditWord,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
