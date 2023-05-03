//ignore_for_file: avoid_dynamic_calls

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/data/graphql/graphql_custom_variable.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/graphql_variables_processor.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

void main() {
  late GraphQLVariablesProcessor processor;

  test("should process deeply nested Custom variables in lists", () async {
    final variable1 = _TestVariable();
    final variable2 = _TestVariable();
    final variable3 = _TestVariable();
    final variables = {
      "text_key": "text_key",
      "variable1": variable1,
      "list": [
        {
          "key1": "value",
          "variable2": variable2,
          "another_list": [
            variable3,
          ],
        }
      ]
    };

    final result = await processor.processVariablesMap(variables);
    expect(result.isSuccess, true);
    final processedVars = result.getSuccess()!;
    expect(processedVars['variable1'], "processed");
    expect(processedVars["list"][0]["variable2"], "processed");
    expect(processedVars["list"][0]["another_list"][0], "processed");
    expect(variable1.completeCount, 1);
    expect(variable2.completeCount, 1);
    expect(variable3.completeCount, 1);
  });

  test("should process list of custom variables", () async {
    final variable1 = _TestVariable();
    final variable2 = _TestVariable();
    final variable3 = _TestVariable();
    final variables = {
      "list": [
        variable1,
        variable2,
        variable3,
      ],
    };

    final result = await processor.processVariablesMap(variables);
    expect(result.isSuccess, true);
    final processedVars = result.getSuccess()!;
    expect(processedVars['list'][0], "processed");
    expect(processedVars['list'][1], "processed");
    expect(processedVars['list'][2], "processed");
    expect(variable1.completeCount, 1);
    expect(variable2.completeCount, 1);
    expect(variable3.completeCount, 1);
  });

  setUp(() {
    processor = GraphQLVariablesProcessor();
  });
}

class _TestVariable implements GraphQLCustomVariable {
  int completeCount = 0;

  @override
  Future<Either<GraphQLFailure, dynamic>> getGraphQLVariable() async {
    completeCount++;
    return success("processed");
  }
}
