import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:graphql/client.dart' as gql;
import 'package:picnic_app/core/data/graphql/dio_link/exceptions.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';

class GraphQLFailureMapper {
  const GraphQLFailureMapper();

  GraphQLFailure mapException(Object? exception, [StackTrace? stackTrace]) {
    final isUnauthenticatedDioResponse = _isUnauthenticatedDioResponse(exception);
    final isUnauthenticatedGraphqlErrors = exception is gql.OperationException &&
        exception.graphqlErrors.any((element) => element.message.contains("Unauthenticated"));
    final isGqlErrorUnauthenticated = exception is gql.GraphQLError && exception.message.contains("Unauthenticated");
    if (isUnauthenticatedDioResponse || isUnauthenticatedGraphqlErrors || isGqlErrorUnauthenticated) {
      return GraphQLFailure.unauthenticated(exception);
    }
    return GraphQLFailure.unknown(exception);
  }

  bool _isUnauthenticatedDioResponse(Object? exception) {
    gql.LinkException? linkException;
    if (exception is gql.OperationException) {
      linkException = exception.linkException;
    } else if (exception is gql.LinkException) {
      linkException = exception;
    }

    dio.Response<dynamic>? response;
    if (linkException is DioLinkServerException) {
      response = linkException.response;
    }

    final is403 = response?.statusCode == HttpStatus.forbidden;
    final isUnauthenticatedHttpException = jsonEncode(response?.data ?? {}).contains("Unauthenticated");
    return is403 || isUnauthenticatedHttpException;
  }
}
