import 'package:flutter/material.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_comment.dart';

class GetCommentsQueryGenerator {
  const GetCommentsQueryGenerator();

  @visibleForTesting
  static const commentsExternalLimit = 20;

  /// Builds get comments query which suppose to query all comments up to specified level of [maxDepth]
  /// Resulting query has the following parameters:
  /// `postId` - post ID, mandatory
  /// `parentId`- parent comment's ID, optional
  /// `cursor1`, `cursor2`, `cursorN` - cursors for each level of nesting
  // ignore: long-method
  String build({
    required int maxDepth,
    int? limitPerLevel,
    bool reverse = false,
  }) {
    limitPerLevel ??= commentsExternalLimit;
    if (maxDepth < 1) {
      throw ArgumentError.value(
        maxDepth,
        'maxDepth',
        'Must be more or equal to 1',
      );
    }

    var repliesConnection = '';
    final cursorNames = <String>[];

    for (var currentDepthLevel = maxDepth; currentDepthLevel > 1; currentDepthLevel--) {
      final cursorName = _cursorVariableName(currentDepthLevel);
      cursorNames.insert(0, cursorName);
      repliesConnection = _repliesConnectionPart(cursorName, repliesConnection);
    }

    final firstCursorName = _cursorVariableName(1);
    cursorNames.insert(0, firstCursorName);

    final cursorVariablesArgumentList = _cursorVariablesArgumentList(
      cursorNames.map(
        (name) => _cursorVariableDefinition(
          name,
          limit: limitPerLevel!,
          reverse: reverse,
        ),
      ),
    );

    return _query(
      fragments: _fragments(),
      cursorVariableName: firstCursorName,
      cursorVariablesArgumentList: cursorVariablesArgumentList,
      repliesConnection: repliesConnection,
    );
  }

  String _cursorVariableName(int depthLevel) => '\$cursor$depthLevel';

  String _cursorVariableDefinition(
    String cursorVariableName, {
    required int limit,
    bool reverse = false,
  }) =>
      '$cursorVariableName: CursorInput! = { id: "" limit: $limit dir: ${reverse ? "back" : "forward"} }';

  String _cursorVariablesArgumentList(Iterable<String> cursorVariableDefinition) => cursorVariableDefinition.join('\n');

  String _query({
    required String fragments,
    required String cursorVariableName,
    required String cursorVariablesArgumentList,
    String repliesConnection = '',
  }) =>
      '''
$fragments

query (
  \$postId: ID!, 
  \$parentId: String = "", 
  $cursorVariablesArgumentList
){
  getComments(data: {
    postId: \$postId
    parentId: \$parentId,
    cursor: $cursorVariableName
  }){
    pageInfo { ...PageFields }
    edges {
      node {
        ...CommentFields
        $repliesConnection
      }
    }
  }
}
''';

  String _repliesConnectionPart(
    String cursorVariableName,
    String repliesConnection,
  ) =>
      '''
repliesConnection(cursor: $cursorVariableName) {
  pageInfo { ...PageFields }
  edges { 
    node {
      ...CommentFields
      $repliesConnection
    }
  }
}
''';

  String _fragments() => '''
fragment CommentFields on Comment {
  ${GqlTemplate().comment}
}

fragment PageFields on PageInfo {
  firstId
  lastId
  hasNextPage
  hasPreviousPage
}
''';
}
