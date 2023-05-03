import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/features/posts/data/model/gql_create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content_input.dart';

import '../../../mocks/stubs.dart';

void main() {
  test(
    "should translate TextPostContentInput int gql variables",
    () async {
      final gqlVariable = GqlCreatePostInput.fromDomain(Stubs.createTextPostInput).toJson();
      expect(gqlVariable['videoContent'], isNull);

      expect(gqlVariable['imageContent'], isNull);
      expect(gqlVariable['linkContent'], isNull);
      expect(gqlVariable['pollContent'], isNull);

      final textContent = gqlVariable['textContent'] as Map<String, dynamic>;
      expect(textContent['text'], (Stubs.createTextPostInput.content as TextPostContentInput).text.trim());
      expect(textContent['more'], (Stubs.createTextPostInput.content as TextPostContentInput).additionalText.trim());
      expect(textContent['color'], (Stubs.createTextPostInput.content as TextPostContentInput).color.value);
    },
  );
  test(
    "should translate ImagePostContentInput int gql variables",
    () async {
      final gqlVariable = GqlCreatePostInput.fromDomain(Stubs.createImagePostInput).toJson();
      expect(gqlVariable['videoContent'], isNull);
      expect(gqlVariable['linkContent'], isNull);
      expect(gqlVariable['pollContent'], isNull);
      expect(gqlVariable['textContent'], isNull);

      final imageContent = gqlVariable['imageContent'] as Map<String, dynamic>;
      final imageFile = imageContent['imageFile'];
      expect(imageFile, isA<GraphQLFileVariable>());
      expect(
        (imageFile as GraphQLFileVariable).filePath,
        (Stubs.createImagePostInput.content as ImagePostContentInput).imageFilePath,
      );
    },
  );
}
