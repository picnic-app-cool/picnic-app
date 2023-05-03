import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/data/get_comments_query_generator.dart';

void main() {
  late GetCommentsQueryGenerator getCommentsQueryGenerator;

  test("should generate correct query for 1 level of comments nesting", () async {
    final result = getCommentsQueryGenerator.build(maxDepth: 1);
    expect(
      result.replaceAll(RegExp(r'\s'), ''),
      _commentsQueryDepth1.replaceAll(RegExp(r'\s'), ''),
    );
  });

  test("should generate correct query for 3 levels of comments nesting", () async {
    final result = getCommentsQueryGenerator.build(maxDepth: 3);
    expect(
      result.replaceAll(RegExp(r'\s'), ''),
      _commentsQueryDepth3.replaceAll(RegExp(r'\s'), ''),
    );
  });

  setUp(() {
    getCommentsQueryGenerator = const GetCommentsQueryGenerator();
  });
}

String get _commentsQueryDepth1 => '''
fragment CommentFields on Comment {
  id
  text
  author {
    id
    username
    profileImage
    isVerified
  }
  repliesCount
  likesCount
  iReacted
  postId
  createdAt
  deletedAt
}

fragment PageFields on PageInfo {
  firstId
  lastId
  hasNextPage
  hasPreviousPage
}


query (
  \$postId: ID!, 
  \$parentId: String = "", 
  \$cursor1: CursorInput! = { id: "" limit: ${GetCommentsQueryGenerator.commentsExternalLimit} dir: forward }
){
  getComments(data: {
    postId: \$postId
    parentId: \$parentId,
    cursor: \$cursor1
  }){
    pageInfo { ...PageFields }
    edges {
      node {
        ...CommentFields
      }
    }
  }
}
''';

String get _commentsQueryDepth3 => '''
fragment CommentFields on Comment {
  id
  text
  author {
    id
    username
    profileImage
    isVerified
  }
  repliesCount
  likesCount
  iReacted
  postId
  createdAt
  deletedAt
}

fragment PageFields on PageInfo {
  firstId
  lastId
  hasNextPage
  hasPreviousPage
}


query (
  \$postId: ID!, 
  \$parentId: String = "", 
  \$cursor1: CursorInput! = { id: "" limit: ${GetCommentsQueryGenerator.commentsExternalLimit} dir: forward }
  \$cursor2: CursorInput! = { id: "" limit: ${GetCommentsQueryGenerator.commentsExternalLimit} dir: forward }
  \$cursor3: CursorInput! = { id: "" limit: ${GetCommentsQueryGenerator.commentsExternalLimit} dir: forward }
){
  getComments(data: {
    postId: \$postId
    parentId: \$parentId,
    cursor: \$cursor1
  }){
    pageInfo { ...PageFields }
    edges {
      node {
        ...CommentFields
        repliesConnection(cursor: \$cursor2) {
          pageInfo { ...PageFields }
          edges { 
            node {
              ...CommentFields
              repliesConnection(cursor: \$cursor3) {
                pageInfo { ...PageFields }
                edges { 
                  node {
                    ...CommentFields
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
''';
