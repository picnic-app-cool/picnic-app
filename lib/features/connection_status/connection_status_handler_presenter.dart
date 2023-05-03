import 'dart:async';

import 'package:picnic_app/features/connection_status/connection_status_handler_navigator.dart';
import 'package:picnic_app/features/connection_status/domain/model/connection_status.dart';
import 'package:picnic_app/features/connection_status/domain/model/presentable_connection_status.dart';
import 'package:picnic_app/features/connection_status/domain/use_cases/get_connection_status_use_case.dart';

class ConnectionStatusHandlerPresenter {
  ConnectionStatusHandlerPresenter(
    this.navigator,
    this._getConnectionStatusUseCase,
  );

  final ConnectionStatusHandlerNavigator navigator;
  final GetConnectionStatusUseCase _getConnectionStatusUseCase;

  var _currentStatus = PresentableConnectionStatus.none;
  Timer? _timer;

  void onInit() {
    _getConnectionStatusUseCase.execute().listen(_reactToConnectionStatusChange);
  }

  void onDispose() {
    _timer?.cancel();
  }

  // ignore: long-method
  void _reactToConnectionStatusChange(
    ConnectionStatus status,
  ) {
    _timer?.cancel();

    switch (status) {
      case ConnectionStatus.online:
        switch (_currentStatus) {
          case PresentableConnectionStatus.online:
          case PresentableConnectionStatus.none:
            break;
          case PresentableConnectionStatus.offline:
          case PresentableConnectionStatus.reconnecting:
            _updatePresentableConnectionStatus(PresentableConnectionStatus.online);
            _timer = Timer(
              const Duration(seconds: 3),
              () => _updatePresentableConnectionStatus(PresentableConnectionStatus.none),
            );
            break;
        }
        break;
      case ConnectionStatus.offline:
        switch (_currentStatus) {
          case PresentableConnectionStatus.online:
          case PresentableConnectionStatus.none:
            _updatePresentableConnectionStatus(PresentableConnectionStatus.reconnecting);
            _timer = Timer(
              const Duration(seconds: 15),
              () => _updatePresentableConnectionStatus(PresentableConnectionStatus.offline),
            );
            break;
          case PresentableConnectionStatus.offline:
          case PresentableConnectionStatus.reconnecting:
            break;
        }
        break;
    }
  }

  void _updatePresentableConnectionStatus(PresentableConnectionStatus status) {
    _currentStatus = status;
    navigator.showConnectionStatus(status: status);
  }
}
