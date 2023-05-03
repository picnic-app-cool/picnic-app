import 'package:picnic_app/core/data/graphql/model/gql_circle.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';

class GqlCircleGroup {
  const GqlCircleGroup({
    required this.name,
    required this.topCirclesJson,
  });

  factory GqlCircleGroup.fromJson(Map<String, dynamic> json) {
    final group = asT<Map<String, dynamic>>(json, "group");
    return GqlCircleGroup(
      name: asT(group, "name"),
      topCirclesJson: asList<GqlCircle>(
        json,
        'topCircles',
        (element) => GqlCircle.fromJson(element),
      ),
    );
  }

  final String name;
  final List<GqlCircle> topCirclesJson;

  CircleGroup toDomain() => CircleGroup(
        name,
        topCirclesJson.map((e) => e.toDomain()).toList(growable: false),
      );
}
