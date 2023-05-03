import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presentation_model.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presenter.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/widgets/post_collection_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SavePostToCollectionPage extends StatefulWidget with HasPresenter<SavePostToCollectionPresenter> {
  const SavePostToCollectionPage({
    super.key,
    required this.presenter,
  });

  @override
  final SavePostToCollectionPresenter presenter;

  @override
  State<SavePostToCollectionPage> createState() => _SavePostToCollectionPageState();
}

class _SavePostToCollectionPageState extends State<SavePostToCollectionPage>
    with PresenterStateMixin<SavePostToCollectionViewModel, SavePostToCollectionPresenter, SavePostToCollectionPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            appLocalizations.saveToCollection,
            style: styles.title30,
          ),
          Flexible(
            child: stateObserver(
              builder: (context, state) => PicnicPagingListView<Collection>(
                paginatedList: state.postCollections,
                loadMore: presenter.loadMore,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 20),
                loadingBuilder: (_) => const PicnicLoadingIndicator(),
                itemBuilder: (context, postCollection) {
                  return PostCollectionListItem(
                    postCollection: postCollection,
                    onTap: () => presenter.onTapCollection(postCollection),
                  );
                },
              ),
            ),
          ),
          Divider(
            color: colors.blackAndWhite.shade300,
          ),
          const Gap(20),
          PicnicButton(
            onTap: presenter.onTapCreateNewCollectionNavigation,
            title: appLocalizations.createANewCollection,
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
