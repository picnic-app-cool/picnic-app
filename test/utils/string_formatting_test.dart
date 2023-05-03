import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';

void main() {
  test("should format duration as mm:ss", () {
    expect(Duration.zero.formattedMMss, "00:00");
    expect(const Duration(seconds: 120).formattedMMss, "02:00");
    expect(const Duration(seconds: 320).formattedMMss, "05:20");
    expect(const Duration(seconds: 29).formattedMMss, "00:29");
    expect(const Duration(milliseconds: 29501).formattedMMss, "00:30");
  });
}
