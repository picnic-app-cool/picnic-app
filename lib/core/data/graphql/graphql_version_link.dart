import 'dart:async';

import 'package:graphql/client.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/use_cases/set_app_info_use_case.dart';
import 'package:picnic_app/core/utils/logging.dart';

class GraphQLVersionLink extends Link {
  GraphQLVersionLink(
    this._appInfoStore,
    this._setAppInfoUseCase,
  );

  final AppInfoStore _appInfoStore;
  final SetAppInfoUseCase _setAppInfoUseCase;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    var req = request;
    if (_appInfoStore.appInfo.buildNumber == "") {
      await _setAppInfoUseCase.execute();
    }
    var os = _appInfoStore.appInfo.deviceInfo.isAndroid ? "android" : "ios";
    var appVersion = _appInfoStore.appInfo.appVersion;
    debugLog("'app-agent': 'picnic/$os/$appVersion'");
    req = request.updateContextEntry<HttpLinkHeaders>(
      (HttpLinkHeaders? headers) {
        return HttpLinkHeaders(
          headers: <String, String>{
            // put oldest headers
            ...headers?.headers ?? <String, String>{},
            // and add a new headers
            'app-agent': 'picnic/$os/$appVersion',
          },
        );
      },
    );

    yield* forward!(req);
  }
}
