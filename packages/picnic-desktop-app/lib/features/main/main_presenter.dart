import 'package:bloc/bloc.dart';
import 'package:picnic_desktop_app/features/main/main_navigator.dart';
import 'package:picnic_desktop_app/features/main/main_presentation_model.dart';

class MainPresenter extends Cubit<MainViewModel> {
  MainPresenter(
    super.model,
    this.navigator,
  );

  final MainNavigator navigator;

  // ignore: unused_element
  MainPresentationModel get _model => state as MainPresentationModel;
}
