import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';

void main() {
  test(
    'asList should work for Json objects',
    () {
      final json = {
        'list': [
          {'id': 'id1', 'value': 'value1'},
          {'id': 'id2', 'value': 'value2'},
        ]
      };

      final list = asList(
        json,
        'list',
        _SampleJsonObject.fromJson,
      );

      expect(list.length, 2);
      expect(list[0], isA<_SampleJsonObject>());
      expect(list[0].id, 'id1');
      expect(list[0].value, 'value1');
      expect(list[1].id, 'id2');
      expect(list[1].value, 'value2');
    },
  );

  test(
    'asList should work for json primitives',
    () {
      final json = {
        'list': ["string1", "string2"]
      };

      final list = asListPrimitive<String>(
        json,
        'list',
      );

      expect(list.length, 2);
      expect(list[0], isA<String>());
      expect(list[0], 'string1');
      expect(list[1], 'string2');
    },
  );
}

class _SampleJsonObject {
  final String id;
  final String value;

  const _SampleJsonObject({
    required this.id,
    required this.value,
  });

  factory _SampleJsonObject.fromJson(Map<String, dynamic> json) {
    return _SampleJsonObject(
      id: asT<String>(json, 'id'),
      value: asT<String>(json, 'value'),
    );
  }
}
