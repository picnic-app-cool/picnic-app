import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_initial_params.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presentation_model.dart';

class AboutElectionsPresenter extends Cubit<AboutElectionsViewModel> {
  AboutElectionsPresenter(
    super.model,
    this.navigator,
  );

  final AboutElectionsNavigator navigator;

  // ignore: unused_element
  AboutElectionsPresentationModel get _model => state as AboutElectionsPresentationModel;

  void onTapContinue() {
    navigator.openCircleCreationSuccess(
      CircleCreationSuccessInitialParams(
        circle: _model.circle!,
        createPostInput: _model.createPostInput!,
        createCircleWithoutPost: _model.createCircleWithoutPost!,
      ),
    );
  }
}
