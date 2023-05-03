import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/discord/domain/use_cases/connect_discord_server_use_case.dart';
import 'package:picnic_app/features/discord/domain/use_cases/get_discord_config_use_case.dart';
import 'package:picnic_app/features/discord/domain/use_cases/revoke_discord_webhook_use_case.dart';
import 'package:picnic_app/features/discord/link_discord_navigator.dart';
import 'package:picnic_app/features/discord/link_discord_presentation_model.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class LinkDiscordPresenter extends Cubit<LinkDiscordViewModel> {
  LinkDiscordPresenter(
    super.model,
    this._clipboardManager,
    this._connectDiscordServerUseCase,
    this._getDiscordServerUseCase,
    this._revokeDiscordServerUseCase,
    this._navigator,
  );

  final ClipboardManager _clipboardManager;
  final ConnectDiscordServerUseCase _connectDiscordServerUseCase;
  final RevokeDiscordWebhookUseCase _revokeDiscordServerUseCase;
  final GetDiscordConfigUseCase _getDiscordServerUseCase;
  final LinkDiscordNavigator _navigator;

  // ignore: unused_element
  LinkDiscordPresentationModel get _model => state as LinkDiscordPresentationModel;

  Future<void> onInit() async {
    await _getDiscordServerUseCase.execute(circleId: _model.circleId).doOn(
          success: (configResponse) {
            tryEmit(
              _model.copyWith(
                serverIsConnected: configResponse.webhookConfigured,
              ),
            );
          },
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
        );
  }

  void onWebhookInputChanged(String text) {
    tryEmit(_model.copyWith(webhookUrl: text, urlShouldAutoComplete: false));
  }

  void onTapDeleteIcon() {
    tryEmit(_model.copyWith(webhookUrl: '', urlShouldAutoComplete: true));
  }

  Future<void> onTapClipboardIcon() async {
    final clipboardText = await _clipboardManager.getText();
    tryEmit(_model.copyWith(webhookUrl: clipboardText, urlShouldAutoComplete: true));
  }

  Future<void> onTapBottomButton() async {
    if (_model.isButtonEnabled) {
      if (_model.serverIsConnected) {
        await _onTapRevoke();
      } else {
        await _onTapConnect();
      }
    }
  }

  Future<void> _onTapConnect() async {
    await _connectDiscordServerUseCase
        .execute(
          circleId: _model.circleId,
          serverWebhook: _model.webhookUrl,
        )
        .doOn(
          success: (seeds) {
            tryEmit(_model.copyWith(serverIsConnected: true));
          },
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> _onTapRevoke() async {
    await _navigator.showRevokeBottomSheet(
      onTapRevoke: _onTapRevokeConfirmation,
      onTapCancel: () => _navigator.close(),
    );
  }

  Future<void> _onTapRevokeConfirmation() async {
    await _revokeDiscordServerUseCase
        .execute(
          circleId: _model.circleId,
        )
        .doOn(
          success: (seeds) {
            tryEmit(
              _model.copyWith(
                serverIsConnected: false,
                webhookUrl: '',
                urlShouldAutoComplete: true,
              ),
            );
            _navigator.close();
          },
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
        );
  }
}
