import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config_type.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';

bool isPostingEnabled({required PostType postType, required Circle circle}) {
  if (circle.isDirector) {
    return true;
  }
  final configs = circle.configs;
  switch (postType) {
    case PostType.text:
      var config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.text);
      return config?.enabled ?? true;
    case PostType.image:
      var config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.photo);
      return config?.enabled ?? true;
    case PostType.video:
      var config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.video);
      return config?.enabled ?? true;
    case PostType.link:
      var config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.link);
      return config?.enabled ?? true;
    case PostType.poll:
      var config = configs.firstWhereOrNull((element) => element.type == CircleConfigType.poll);
      return config?.enabled ?? true;
    case PostType.unknown:
      return true;
  }
}
