import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_navigator.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_presentation_model.dart';

class PodWebViewPresenter extends Cubit<PodWebViewViewModel> {
  PodWebViewPresenter(
    super.model,
    this.navigator,
  );

  final PodWebViewNavigator navigator;

  // ignore: unused_element
  PodWebViewPresentationModel get _model => state as PodWebViewPresentationModel;
}
