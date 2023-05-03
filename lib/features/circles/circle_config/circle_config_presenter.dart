import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/core/domain/use_cases/update_circle_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_navigator.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_default_circle_config_use_case.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_initial_params.dart';
import 'package:picnic_app/features/create_circle/domain/use_cases/create_circle_use_case.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class CircleConfigPresenter extends Cubit<CircleConfigViewModel> {
  CircleConfigPresenter(
    super.model,
    this.navigator,
    this._getDefaultCircleConfigUseCase,
    this._createCircleUseCase,
    this._updateCircleUseCase,
  );

  final CircleConfigNavigator navigator;
  final GetDefaultCircleConfigUseCase _getDefaultCircleConfigUseCase;
  final CreateCircleUseCase _createCircleUseCase;
  final UpdateCircleUseCase _updateCircleUseCase;

  // ignore: unused_element
  CircleConfigPresentationModel get _model => state as CircleConfigPresentationModel;

  void onInit() {
    if (_model.isNewCircle) {
      _getDefaultCircleConfigUseCase
          .execute()
          .observeStatusChanges(
            (configListResult) => tryEmit(
              _model.copyWith(
                configListResult: configListResult,
              ),
            ),
          )
          .doOn(success: (list) => tryEmit(_model.copyWith(configs: list)));
    }
  }

  void onConfigUpdated(CircleConfig config, {required bool value}) =>
      tryEmit(_model.byUpdatingConfig(config, value: value));

  void onTapSave() => _model.isNewCircle ? _createCircle() : _updateCircle();

  void onDisabledConfigTap() {
    navigator.showDisabledBottomSheet(
      title: appLocalizations.unableToEditConfigTitle,
      description: appLocalizations.unableToEditConfigDescription,
      onTapClose: () => navigator.close(),
    );
  }

  void _createCircle() => _createCircleUseCase
      .execute(input: _model.createCircleInput.copyWith(configs: _model.configs)) //
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(createCircleFutureResult: result)),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (newCircle) {
          final createPostInput = _model.createCircleWithoutPost
              ? _model.createPostInput
              : _model.createPostInput.copyWith(circleId: newCircle.id);

          if (_model.showSeeds) {
            navigator.openCircleCreationRules(
              CircleCreationRulesInitialParams(
                circle: newCircle,
                createPostInput: createPostInput,
              ),
            );
          } else {
            navigator.openAboutElections(
              AboutElectionsInitialParams(
                circle: newCircle,
                createPostInput: createPostInput,
                createCircleWithoutPost: _model.createCircleWithoutPost,
              ),
            );
          }
        },
      );

  void _updateCircle() => _updateCircleUseCase
      .execute(
        input: UpdateCircleInput.updateCircle(_model.circle.copyWith(configs: _model.configs)),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (updatedCircle) => navigator.closeWithResult(updatedCircle),
      );
}
