import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoadingSplashPresentationModel implements LoadingSplashViewModel {
  /// Creates the initial state
  LoadingSplashPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoadingSplashInitialParams initialParams,
  );

  /// Used for the copyWith method
  LoadingSplashPresentationModel._();

  //TODO Waiting for BE implementation https://picnic-app.atlassian.net/browse/GS-5311
  @override
  Circle get circle => const Circle.empty().copyWith(name: 'roblox circle', emoji: '😁');

  //TODO Waiting for BE implementation https://picnic-app.atlassian.net/browse/GS-5311
  @override
  String get description =>
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text..";

  //TODO Waiting for BE implementation https://picnic-app.atlassian.net/browse/GS-5311
  @override
  String get title => 'did you know...';

  LoadingSplashPresentationModel copyWith() {
    return LoadingSplashPresentationModel._();
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoadingSplashViewModel {
  Circle get circle;
  String get title;
  String get description;
}
