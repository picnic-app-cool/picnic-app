//ignore_for_file: forbidden_import_in_presentation
import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_initial_params.dart';
import 'package:picnic_app/features/debug/debug/debug_navigator.dart';
import 'package:picnic_app/features/debug/debug/debug_presentation_model.dart';
import 'package:picnic_app/features/debug/domain/use_cases/change_environment_use_case.dart';
import 'package:picnic_app/features/debug/domain/use_cases/invalidate_token_use_case.dart';
import 'package:picnic_app/features/debug/domain/use_cases/restart_app_use_case.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_initial_params.dart';
import 'package:picnic_app/features/debug/log_console/log_console_initial_params.dart';

class DebugPresenter extends Cubit<DebugViewModel> {
  DebugPresenter(
    DebugPresentationModel model,
    this.navigator,
    this._invalidateTokenUseCase,
    this._restartAppUseCase,
    this._environmentConfigProvider,
    this._changeEnvironmentUseCase,
  ) : super(model);

  final DebugNavigator navigator;
  final InvalidateTokenUseCase _invalidateTokenUseCase;
  final ChangeEnvironmentUseCase _changeEnvironmentUseCase;
  final RestartAppUseCase _restartAppUseCase;
  final EnvironmentConfigProvider _environmentConfigProvider;

  // ignore: unused_element
  DebugPresentationModel get _model => state as DebugPresentationModel;

  Future<void> onInit() async {
    await _initEnvironmentInfo();
    await _initEnvironmentHeaders();
    await _initShouldUseShortLivedTokens();
  }

  void onTapLogConsole() => navigator.openLogConsole(
        const LogConsoleInitialParams(),
      );

  void onTapIndexPage() => navigator.openFeaturesIndex(
        const FeaturesIndexInitialParams(),
      );

  void onTapFeatureFlags() => navigator.openFeatureFlags(
        const FeatureFlagsInitialParams(),
      );

  Future<void> onTapRestart() async => _restartAppUseCase.execute();

  void onTapSimulateInvalidToken() => _invalidateTokenUseCase.execute().doOn(
        success: (_) => navigator.showSnackBar('token invalidated successfully'),
      );

  void onTapEnvironment(EnvironmentConfigSlug value) => _changeEnvironmentUseCase
      .execute(slug: value)
      // no need to observe success since it will restart app
      .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));

  void onTapDeleteHeader(MapEntry<String, String> value) {
    tryEmit(_model.byRemovingHeader(value.key));
    _saveHeaders();
  }

  void onTapAddHeader() => _updateHeader(null);

  void onTapEditHeader(MapEntry<String, String> value) {
    _updateHeader(value);
  }

  //ignore: avoid_positional_boolean_parameters
  Future<void> onChangedShortLivedTokens(bool useShortLivedTokens) async {
    await _environmentConfigProvider.setShouldUseShortLivedAuthTokens(shouldUse: useShortLivedTokens);
    await _initShouldUseShortLivedTokens();
  }

  Future<void> _updateHeader(MapEntry<String, String>? header) async {
    final newHeader = await navigator.showEditHeaderDialog(header: header);
    if (newHeader != null) {
      tryEmit(_model.byUpdatingHeader(newHeader));
      await _saveHeaders();
    }
  }

  Future<void> _initEnvironmentInfo() async {
    final slug = (await _environmentConfigProvider.getConfig()).slug;
    tryEmit(
      _model.copyWith(
        selectedEnvironment: slug,
      ),
    );
  }

  Future<void> _saveHeaders() async {
    await _environmentConfigProvider.updateAdditionalGraphQLHeaders(
      _model.additionalGraphqlHeaders,
    );
  }

  Future<void> _initEnvironmentHeaders() async {
    final headers = await _environmentConfigProvider.getAdditionalGraphQLHeaders();
    tryEmit(
      _model.copyWith(
        additionalGraphqlHeaders: headers,
      ),
    );
  }

  Future<void> _initShouldUseShortLivedTokens() async {
    final usesShortLivedTokens = await _environmentConfigProvider.shouldUseShortLivedAuthTokens();
    tryEmit(
      _model.copyWith(
        usesShortLivedTokens: usesShortLivedTokens,
      ),
    );
  }
}
