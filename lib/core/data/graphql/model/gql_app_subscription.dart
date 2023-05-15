import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/app_subscription.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlAppSubscription {
  const GqlAppSubscription({
    required this.id,
    required this.description,
  });

  //ignore: long-method
  factory GqlAppSubscription.fromJson(Map<String, dynamic>? json) {
    return GqlAppSubscription(
      id: asT<String>(json, 'id'),
      description: asT<String>(json, 'description'),
    );
  }

  final String id;
  final String description;

  AppSubscription toDomain() => AppSubscription(
        id: Id(id),
        description: description,
      );
}
