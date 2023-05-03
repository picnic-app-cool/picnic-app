import 'dart:io';

import 'package:recaptcha_verification/src/webview/recaptcha_html.dart';

class RecaptchaVerificationServer {
  final String _siteKey;
  late void Function(Exception e) _onError;
  late final HttpServer _server;
  late final String url;

  RecaptchaVerificationServer(this._siteKey);

  set onError(void Function(Exception e) callback) {
    _onError = callback;
  }

  Future<void> start() async {
    final address = InternetAddress.loopbackIPv4;
    _server = await HttpServer.bind(address, 0);

    _server.listen((req) async {
      try {
        final res = req.response;
        final body = _handleRequest(req);

        if (body == null) {
          res
            ..statusCode = 404
            ..write('Not found');
        } else {
          res
            ..statusCode = 200
            ..headers.add('content-type', 'text/html')
            ..write(body);
        }

        await req.response.close();
      } on Exception catch (e) {
        _onError(e);
      }
    });

    url = 'http://localhost:${_server.port}';
  }

  Future<void> close() async {
    await _server.close();
  }

  String? _handleRequest(HttpRequest req) {
    final uri = req.requestedUri;

    if (uri.path == '/' && uri.queryParameters.isEmpty) {
      return recaptchaHTML(_siteKey, "");
    }

    if (uri.query.contains('response')) {
      return responseHTML(
        'Success',
        'Successful verification!',
      );
    }

    if (uri.query.contains('error-code')) {
      Future.microtask(() {
        _onError(Exception(uri.queryParameters['error-code']));
      });

      return responseHTML(
        'Captcha check failed.',
        '${uri.queryParameters['error-code']}',
      );
    }

    return null;
  }
}
