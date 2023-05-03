import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/collection_counter.dart';

class GqlCollectionCounter {
  const GqlCollectionCounter({
    required this.posts,
  });

  factory GqlCollectionCounter.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlCollectionCounter(
      posts: asT<int>(json, 'posts'),
    );
  }

  final int posts;

  CollectionCounter toDomain() {
    return CollectionCounter(
      posts: posts,
    );
  }
}
