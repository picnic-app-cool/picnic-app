import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/profile/achievements/achievements_navigator.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presentation_model.dart';

class AchievementsPresenter extends Cubit<AchievementsViewModel> {
  AchievementsPresenter(
    AchievementsPresentationModel model,
    this.navigator,
  ) : super(model);

  final AchievementsNavigator navigator;

  // ignore: unused_element
  AchievementsPresentationModel get _model => state as AchievementsPresentationModel;
}
