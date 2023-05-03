import 'package:picnic_app/core/data/utils/safe_convert.dart';

class GqlEdge {
  GqlEdge({
    required this.cursorId,
    required this.node,
    required this.relations,
  });

  factory GqlEdge.fromJson(Map<String, dynamic> json) => GqlEdge(
        node: asT<Map<String, dynamic>>(json, 'node'),
        cursorId: asT<String>(json, 'cursorId'),
        relations: asT<Map<String, dynamic>>(
          json,
          'relations',
          defaultValue: {},
        ),
      );

  final String cursorId;
  final Map<String, dynamic> node;
  final Map<String, dynamic> relations;
}
