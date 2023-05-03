import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_custom_variable.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class GraphQLVariablesProcessor {
  /// Recursively traverses the variables looking for [GraphQLCustomVariable]s to process them before passing to
  /// GraphQL query/mutate requests
  Future<Either<GraphQLFailure, Map<String, dynamic>>> processVariablesMap(
    Map<String, dynamic> variables,
  ) async {
    return _prepareMap(variables);
  }

  /// recursively traverses [Map] and returns processed result
  Future<Either<GraphQLFailure, Map<String, dynamic>>> _prepareMap(Map<String, dynamic> variables) async {
    final vars = <String, dynamic>{};

    for (final variable in variables.entries) {
      final value = variable.value;

      final variableEither = await _prepareValue(value);
      final variableFailure = variableEither.getFailure();
      if (variableFailure != null) {
        return failure(variableFailure);
      }

      final variableSuccess = variableEither.getSuccess();
      vars[variable.key] = variableSuccess;
    }

    return success(vars);
  }

  /// dynamically determines type of value and recursively traverses it based on the type
  Future<Either<GraphQLFailure, dynamic>> _prepareValue(dynamic value) async {
    if (value is GraphQLCustomVariable) {
      return value.getGraphQLVariable();
    } else if (value is List) {
      return _prepareList(value);
    } else if (value is Map<String, dynamic>) {
      return _prepareMap(value);
    } else {
      return success(value);
    }
  }

  /// recursively traverses [Iterable] and returns processed result
  Future<Either<GraphQLFailure, List<dynamic>>> _prepareList(Iterable<dynamic> list) async {
    final eitherList = await Future.wait(list.map((it) => _prepareValue(it)));
    final failures = eitherList.map((e) => e.getFailure()).whereNotNull();
    if (failures.isNotEmpty) {
      return failure(GraphQLFailure.variablePreparationError(failures));
    }
    return success(eitherList.map((e) => e.getSuccess()).whereNotNull().toList());
  }
}
