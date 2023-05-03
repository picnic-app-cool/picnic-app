import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';

class GqlSound {
  const GqlSound({
    required this.title,
    required this.creator,
    required this.icon,
    required this.url,
    required this.usesCount,
    required this.duration,
    required this.id,
  });

  factory GqlSound.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlSound(
      id: asT<String>(json, 'id'),
      title: asT<String>(json, 'title'),
      creator: asT<String>(json, 'creator'),
      icon: asT<String>(json, 'icon'),
      usesCount: asT<int>(json, 'usesCount'),
      duration: asT<int>(json, 'duration'),
      url: asT<String>(json, 'url'),
    );
  }

  final String id;
  final String title;
  final String creator;
  final String icon;
  final String url;
  final int usesCount;
  final int duration;

  Sound toDomain() => Sound(
        creator: creator,
        icon: ImageUrl(icon),
        title: title,
        url: url,
        usesCount: usesCount,
        duration: Duration(seconds: duration),
        id: Id(id),
      );
}
