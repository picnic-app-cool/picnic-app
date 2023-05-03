import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/force_update/domain/use_case/open_store_use_case.dart';
import 'package:picnic_app/features/force_update/force_update_navigator.dart';
import 'package:picnic_app/features/force_update/force_update_presentation_model.dart';

class ForceUpdatePresenter extends Cubit<ForceUpdateViewModel> {
  ForceUpdatePresenter(
    super.model,
    this.navigator,
    this._openStoreUseCase,
  );

  final ForceUpdateNavigator navigator;
  final OpenStoreUseCase _openStoreUseCase;

  ForceUpdatePresentationModel get _model => state as ForceUpdatePresentationModel;

  Future<void> onTapUpdate() async => _openStoreUseCase.execute(_model.packageName);
}
