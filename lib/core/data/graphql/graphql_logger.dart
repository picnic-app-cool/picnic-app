import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart' as gql;
import 'package:picnic_app/core/data/graphql/dio_link/dio_link_response_context.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:uuid/uuid.dart';

class GraphQLLogger {
  GraphQLLogger(this._currentTimeProvider);

  static const errorMinimumStatusCode = 400;

  final CurrentTimeProvider _currentTimeProvider;

  String logRequest({
    required String doc,
    required Map<String, dynamic> vars,
  }) {
    if (kReleaseMode) {
      return '';
    }
    final requestId = _generateRequestId();
    debugLog(
      """
---------------  ↗️ GQL REQUEST (id: $requestId)  ------------------
${printNode(
        transform(
          parseString(doc),
          [], // not using gq.gql(..) to get rid of `__typename` fields in every request object
        ),
      )}
👉🏻 variables:
${tryJsonEncode(vars)}
""",
    );
    return requestId;
  }

  void logResponse({
    required String requestId,
    required gql.QueryResult<dynamic> result,
    DateTime? executionDate,
  }) {
    if (kReleaseMode) {
      return;
    }
    final diff = executionDate == null ? null : _currentTimeProvider.currentTime.difference(executionDate);
    final responseContext = result.context.entry<DioLinkResponseContext>();
    final statusCode = responseContext?.statusCode ?? 999;
    final isCache = result.source == gql.QueryResultSource.cache;
    final isError = !isCache && (statusCode >= errorMinimumStatusCode || result.hasException);
    debugLog(
      """
---------------${isError ? '❌' : (isCache ? '🪣 CACHED' : '✅ NETWORK️')}  GQL RESPONSE - (status: $statusCode) - ${diff == null ? '' : "(${diff.inMilliseconds}ms) (id: $requestId)"} ---------------
response:\t${tryJsonEncode(responseContext?.rawResponse ?? {})}
headers:\t${tryJsonEncode(responseContext?.headers ?? {})}
source:\t${result.source}
exception:\t${result.exception}
""",
    );
  }

  String tryJsonEncode(dynamic jsonMap) {
    try {
      return const JsonEncoder.withIndent("  ").convert(jsonMap);
    } catch (ex) {
      debugLog("could not encode GraphQL variables to json: $jsonMap");
      return jsonMap.toString();
    }
  }

  /// request id is used to pair request with its response in logs so its easier to distinguish which
  /// response corresponds to which request
  String _generateRequestId() => const Uuid().v1();
}
