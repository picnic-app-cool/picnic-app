import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_navigator.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_presentation_model.dart';

class LoadingSplashPresenter extends Cubit<LoadingSplashViewModel> {
  LoadingSplashPresenter(
    super.model,
    this.navigator,
  );

  final LoadingSplashNavigator navigator;

  // ignore: unused_element
  LoadingSplashPresentationModel get _model => state as LoadingSplashPresentationModel;
}
