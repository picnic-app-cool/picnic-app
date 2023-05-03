import 'package:alchemist/alchemist.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/collection_counter.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/picnic_collection_card.dart';

import '../mocks/stubs.dart';
import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_collection_card',
    widgetBuilder: (context) {
      const counter = 3;
      final collection = Collection(
        id: const Id('collectionId'),
        title: 'Super collection',
        description: 'This is a super collection',
        counters: const CollectionCounter(posts: counter),
        createdAt: Stubs.dateTime.toIso8601String(),
        isPublic: true,
        owner: Stubs.publicProfile,
        previewPosts: List.filled(
          counter,
          const Post.empty().copyWith(
            id: const Id('1'),
            title: 'post title',
            content: const ImagePostContent.empty().copyWith(
              imageUrl: const ImageUrl(
                'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/fairytale-town-of-hallstatt-austria-royalty-free-image-1570204697.jpg?crop=0.447xw:1.00xh;0.211xw,0&resize=980:*',
              ),
            ),
          ),
        ),
      );
      final images = collection.thumbnails;

      return GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'with 3 images',
            child: TestWidgetContainer(
              child: SizedBox(
                width: 300,
                height: 500,
                child: PicnicCollectionCard(
                  images: images,
                  collection: collection,
                  onTap: () {},
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'with 2 images',
            child: TestWidgetContainer(
              child: SizedBox(
                width: 300,
                height: 500,
                child: PicnicCollectionCard(
                  images: images.sublist(0, 2),
                  collection: collection,
                  onTap: () {},
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'with 1 images',
            child: TestWidgetContainer(
              child: SizedBox(
                width: 300,
                height: 500,
                child: PicnicCollectionCard(
                  images: images.sublist(0, 1),
                  collection: collection,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
