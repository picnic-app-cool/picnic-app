import "package:dio/dio.dart" as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:picnic_app/core/data/graphql/dio_link/exceptions.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure_mapper.dart';

void main() {
  late GraphQLFailureMapper mapper;

  test("should parse unauthenticated response", () async {
    final ex = OperationException(
      linkException: DioLinkServerException(
        response: dio.Response<Map<String, dynamic>>(
          data: {
            "errors": [
              {
                "message": "Unauthenticated",
              },
            ]
          },
          requestOptions: dio.RequestOptions(),
          statusCode: 200,
        ),
        parsedResponse: const Response(
          response: {
            "errors": {"message": "Unauthenticated"},
          },
        ),
      ),
    );

    final error = mapper.mapException(ex);
    expect(error.isUnauthenticated, true);
  });

  test("should parse 403 response", () async {
    final ex = OperationException(
      linkException: DioLinkServerException(
        response: dio.Response<Map<String, dynamic>>(
          data: {
            "data": "invalid token",
          },
          requestOptions: dio.RequestOptions(),
          statusCode: 403,
        ),
        parsedResponse: const Response(
          response: {
            "data": "invalid token",
          },
        ),
      ),
    );

    final error = mapper.mapException(ex);
    expect(error.isUnauthenticated, true);
  });

  setUp(() => mapper = const GraphQLFailureMapper());
}
