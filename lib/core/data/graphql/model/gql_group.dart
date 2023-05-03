import 'package:picnic_app/core/data/graphql/model/gql_basic_circle.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlGroup {
  const GqlGroup({
    required this.groupId,
    required this.name,
    required this.circles,
  });

  factory GqlGroup.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlGroup(
      groupId: asT(json, 'groupId'),
      name: asT(json, 'name'),
      circles: asList<GqlBasicCircle>(
        json,
        'circles',
        (element) => GqlBasicCircle.fromJson(element),
      ),
    );
  }

  final String groupId;
  final String name;
  final List<GqlBasicCircle> circles;

  GroupWithCircles toDomain() => GroupWithCircles(
        id: Id(groupId),
        name: name,
        circles: circles.map((circle) => circle.toDomain()).toList(),
      );
}
