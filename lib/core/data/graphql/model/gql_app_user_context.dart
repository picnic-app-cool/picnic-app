import 'package:picnic_app/core/data/utils/safe_convert.dart';

class GqlAppUserContext {
  const GqlAppUserContext({
    required this.usedAt,
    required this.savedAt,
    required this.upvotedAt,
  });

  //ignore: long-method
  factory GqlAppUserContext.fromJson(Map<String, dynamic>? json) {
    return GqlAppUserContext(
      usedAt: asT<String>(json, 'usedAt'),
      savedAt: asT<String>(json, 'savedAt'),
      upvotedAt: asT<String>(json, 'upvotedAt'),
    );
  }

  final String? usedAt;
  final String? savedAt;
  final String? upvotedAt;
}
