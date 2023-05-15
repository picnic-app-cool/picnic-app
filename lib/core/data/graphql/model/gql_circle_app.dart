import 'package:picnic_app/core/data/graphql/model/gql_app.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlCircleApp {
  const GqlCircleApp({
    required this.circleId,
    required this.app,
  });

  //ignore: long-method
  factory GqlCircleApp.fromJson(Map<String, dynamic>? json) {
    GqlApp? app;
    if (json != null && json['app'] != null) {
      app = GqlApp.fromJson((json['app'] as Map).cast());
    }
    return GqlCircleApp(
      circleId: asT<String>(json, 'circleId'),
      app: app,
    );
  }

  final String circleId;
  final GqlApp? app;

  CirclePodApp toDomain() => CirclePodApp(
        circleId: Id(circleId),
        app: app?.toDomain() ?? const PodApp.empty(),
      );
}
