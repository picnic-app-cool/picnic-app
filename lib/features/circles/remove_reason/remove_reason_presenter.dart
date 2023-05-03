import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_navigator.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presentation_model.dart';

class RemoveReasonPresenter extends Cubit<RemoveReasonViewModel> {
  RemoveReasonPresenter(
    RemoveReasonPresentationModel model,
    this.navigator,
  ) : super(model);

  final RemoveReasonNavigator navigator;

  // ignore: unused_element
  RemoveReasonPresentationModel get _model => state as RemoveReasonPresentationModel;

  void onTapContinue() {
    // TODO(GS-8035): Call API for removing the post and navigate back with a [true] : https://picnic-app.atlassian.net/browse/GS-8035
    navigator.closeWithResult(_model.reason);
  }

  void onTextChanged(String value) => tryEmit(_model.copyWith(reason: value));
}
