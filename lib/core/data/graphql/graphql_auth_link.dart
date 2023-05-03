import 'dart:async';

import 'package:graphql/client.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class GraphQLAuthLink extends Link {
  GraphQLAuthLink(
    this._authTokenRepository,
  );

  final AuthTokenRepository _authTokenRepository;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    var req = request;
    final token = await _getToken();
    if (token.isNotEmpty) {
      req = request.updateContextEntry<HttpLinkHeaders>(
        (HttpLinkHeaders? headers) {
          return HttpLinkHeaders(
            headers: <String, String>{
              // put oldest headers
              ...headers?.headers ?? <String, String>{},
              // and add a new headers
              'Authorization': 'Bearer $token',
            },
          );
        },
      );
    }

    yield* forward!(req);
  }

  Future<String> _getToken() async {
    return _authTokenRepository.getAuthToken().asyncFold(
          (fail) => '',
          (success) => success.accessToken,
        );
  }
}
