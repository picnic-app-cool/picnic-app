import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_navigator.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_presentation_model.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_input.dart';
import 'package:picnic_app/features/profile/domain/use_cases/create_collection_use_case.dart';

class CreateNewCollectionPresenter extends Cubit<CreateNewCollectionViewModel> {
  CreateNewCollectionPresenter(
    super.model,
    this.navigator,
    this._createCollectionUseCase,
  );

  final CreateNewCollectionNavigator navigator;
  final CreateCollectionUseCase _createCollectionUseCase;

  // ignore: unused_element
  CreateNewCollectionPresentationModel get _model => state as CreateNewCollectionPresentationModel;

  void onTapClose() => navigator.close();

  Future<void> onTapCreate() => _createCollectionUseCase
      .execute(
        CreateCollectionInput(title: _model.collectionName),
      )
      .doOn(
        success: (collection) => navigator.closeWithResult(collection),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void onCollectionNameInputChanged(String value) {
    if (value != _model.collectionName) {
      tryEmit(_model.copyWith(collectionName: value));
    }
  }
}
