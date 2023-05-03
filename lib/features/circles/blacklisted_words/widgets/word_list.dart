import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class WordList extends StatelessWidget {
  const WordList({
    Key? key,
    required this.getWords,
    required this.words,
    required this.onTapDeleteWord,
    required this.onTapEditWord,
  }) : super(key: key);

  final ValueChanged<String> onTapDeleteWord;
  final ValueChanged<String> onTapEditWord;

  final Future<void> Function() getWords;
  final PaginatedList<String> words;
  static const _wordItemHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    final themeData = PicnicTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: PicnicPagingListView<String>(
        paginatedList: words,
        loadMore: getWords,
        loadingBuilder: (BuildContext context) => const Center(child: PicnicLoadingIndicator()),
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 24, thickness: 1),
        ),
        itemBuilder: (context, word) {
          return PicnicListItem(
            height: _wordItemHeight,
            title: word,
            titleStyle: themeData.styles.body20,
            trailing: Row(
              children: [
                InkWell(
                  onTap: () => onTapEditWord(word),
                  child: Image.asset(
                    Assets.images.edit.path,
                    color: themeData.colors.green.shade300,
                  ),
                ),
                const Gap(24),
                InkWell(
                  onTap: () => onTapDeleteWord(word),
                  child: Image.asset(
                    Assets.images.deleteSolid.path,
                    color: themeData.colors.pink,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
