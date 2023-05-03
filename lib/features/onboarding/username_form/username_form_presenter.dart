import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/check_username_availability_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/throttler.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_navigator.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presentation_model.dart';

class UsernameFormPresenter extends Cubit<UsernameFormViewModel> {
  UsernameFormPresenter(
    UsernameFormPresentationModel model,
    this.navigator,
    this._debouncer,
    this._throttler,
    this._checkUsernameAvailabilityUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final UsernameFormNavigator navigator;
  final Debouncer _debouncer;
  final Throttler _throttler;
  final CheckUsernameAvailabilityUseCase _checkUsernameAvailabilityUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  UsernameFormPresentationModel get _model => state as UsernameFormPresentationModel;

  Future<void>? onTapContinue() => _throttler.throttle(
        const LongDuration(),
        () async {
          if (_model.isLoading) {
            return;
          }
          _logAnalyticsEventUseCase.execute(
            AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingUsernameContinueButton),
          );
          return _callUsernameChangedCallback()
              .observeStatusChanges((result) => tryEmit(_model.copyWith(usernameSelectedResult: result)));
        },
      );

  void onChangedUsername(String value) {
    tryEmit(
      _model.copyWith(
        username: value,
        usernameCheckResult: const FutureResult.pending(),
      ),
    );
    _debouncer.debounce(
      const LongDuration(),
      () => _checkUsername(value),
    );
  }

  Future<dynamic> _callUsernameChangedCallback() async {
    await _model.onUsernameSelectedCallback(_model.username);
    //this makes sure that after the callback succeeds, we prevent any clicking for few more moments to allow
    // for proper screen routing and prevent clicking "continue" button after operation succeeded and before new screen
    // appears
    await Future.delayed(const LongDuration());
  }

  Future<void> _checkUsername(
    String newUsername,
  ) =>
      _checkUsernameAvailabilityUseCase //
          .execute(username: _model.username)
          .observeStatusChanges(
            (result) => tryEmit(
              _model.copyWith(usernameCheckResult: result),
            ),
          );
}
