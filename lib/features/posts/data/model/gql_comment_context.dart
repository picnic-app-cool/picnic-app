import 'package:picnic_app/core/data/utils/safe_convert.dart';

class GqlCommentContext {
  const GqlCommentContext({
    required this.reaction,
  });

  factory GqlCommentContext.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlCommentContext(
      reaction: asT<String>(json, 'reaction'),
    );
  }

  final String? reaction;
}
