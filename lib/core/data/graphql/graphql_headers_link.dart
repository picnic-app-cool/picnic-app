import 'package:graphql/client.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';

class GraphQLHeadersLink extends Link {
  GraphQLHeadersLink(
    this._configProvider,
  );

  final EnvironmentConfigProvider _configProvider;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    var req = request;
    final additionalHeaders = await _configProvider.getAdditionalGraphQLHeaders();

    if (additionalHeaders.isNotEmpty) {
      req = request.updateContextEntry<HttpLinkHeaders>(
        (HttpLinkHeaders? headers) {
          return HttpLinkHeaders(
            headers: <String, String>{
              // put oldest headers
              ...headers?.headers ?? <String, String>{},
              // and add a new headers
              ...additionalHeaders,
            },
          );
        },
      );
    }

    yield* forward!(req);
  }
}
