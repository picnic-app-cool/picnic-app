import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/splash/splash_navigator.dart';
import 'package:picnic_app/features/onboarding/splash/splash_presentation_model.dart';

class SplashPresenter extends Cubit<SplashViewModel> {
  SplashPresenter(
    SplashPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final SplashNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  SplashPresentationModel get _model => state as SplashPresentationModel;

  void onTapGetStarted() {
    _logAnalyticsEventUseCase.execute(AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingGetStartedButton));
    _model.onTapGetStartedCallback();
  }

  void onTapLogin() {
    _logAnalyticsEventUseCase.execute(AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingLoginButton));
    _model.onTapLoginCallback();
  }
}
