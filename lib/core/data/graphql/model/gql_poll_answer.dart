import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer.dart';

class GqlPollAnswer {
  const GqlPollAnswer({
    required this.id,
    required this.imageUrl,
    required this.votesCount,
  });

  factory GqlPollAnswer.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlPollAnswer(
      id: asT<String>(json, 'id'),
      imageUrl: asT<String>(json, 'imageUrl'),
      votesCount: asT<int>(json, 'votesCount'),
    );
  }

  final String id;
  final String imageUrl;
  final int votesCount;

  PollAnswer toDomain() {
    return PollAnswer(
      id: Id(id),
      imageUrl: ImageUrl(imageUrl),
      votesCount: votesCount,
    );
  }
}
