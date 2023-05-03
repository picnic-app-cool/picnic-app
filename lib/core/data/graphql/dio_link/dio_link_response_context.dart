import 'package:graphql/client.dart';

class DioLinkResponseContext extends HttpLinkResponseContext {
  const DioLinkResponseContext({
    required super.statusCode,
    required this.rawResponse,
    super.headers,
    super.rawHeaders,
  });

  final dynamic rawResponse;

  @override
  List<Object?> get fieldsForEquality => super.fieldsForEquality + [rawResponse];
}
