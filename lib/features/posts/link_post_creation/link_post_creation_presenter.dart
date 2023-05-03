import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/get_link_metadata_failure.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_link_metadata_use_case.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presentation_model.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class LinkPostCreationPresenter extends Cubit<LinkPostCreationViewModel> {
  LinkPostCreationPresenter(
    LinkPostCreationPresentationModel model,
    this.navigator,
    this._clipboardManager,
    this._getLinkMetadataUseCase,
  ) : super(model);

  final LinkPostCreationNavigator navigator;
  final ClipboardManager _clipboardManager;
  final GetLinkMetadataUseCase _getLinkMetadataUseCase;

  // ignore: unused_element
  LinkPostCreationPresentationModel get _model => state as LinkPostCreationPresentationModel;

  void onTapNewCircle() => navigator.openCreateCircle(
        const CreateCircleInitialParams(),
      );

  void onTapPaste() => _pasteLink();

  void onTapLink(LinkUrl linkUrl) => navigator.openWebView(linkUrl.url);

  void onTapChangeLink() => tryEmit(_model.copyWith(getLinkMetadataFutureResult: const FutureResult.empty()));

  void onTapPost() => _model.onPostUpdatedCallback(_model.createPostInput);

  Future<void> _pasteLink() async {
    final clipboardText = await _clipboardManager.getText();
    await _getLinkMetadataUseCase
        .execute(link: clipboardText) //
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(getLinkMetadataFutureResult: result)),
        )
        .doOn(
          success: (_) => tryEmit(_model.copyWith(linkUrl: LinkUrl(clipboardText))),
          fail: (fail) {
            if (fail.type == GetLinkMetadataFailureType.invalidLink) {
              navigator.showToastError(fail.displayableFailure());
            } else {
              navigator.showError(fail.displayableFailure());
            }
          },
        );
  }
}
