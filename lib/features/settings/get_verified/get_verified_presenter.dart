import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_navigator.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presentation_model.dart';

class GetVerifiedPresenter extends Cubit<GetVerifiedViewModel> {
  GetVerifiedPresenter(
    GetVerifiedPresentationModel model,
    this.navigator,
  ) : super(model);

  final GetVerifiedNavigator navigator;

  // ignore: unused_element
  GetVerifiedPresentationModel get _model => state as GetVerifiedPresentationModel;

  void onTapBack() => navigator.close();

  void onTapCommunityGuidelines() => navigator.openCommunityGuidelines(const CommunityGuidelinesInitialParams());

  void onTapApply(String url) => navigator.openWebView(url);
}
