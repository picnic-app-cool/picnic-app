import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';

void main() {
  test(
      "The number must be formatted in short format. "
      "For example 14.1K, 956, 156.2M, etc.", () {
    expect(0.formattingToStat(), '0');
    expect(101.formattingToStat(), '101');
    expect(999.formattingToStat(), '999');
    expect(1000.formattingToStat(), '1K');
    expect(1543.formattingToStat(), '1.5K');
    expect(94501.formattingToStat(), '94.5K');
    expect(999999.formattingToStat(), '999.9K');
    expect(1273472.formattingToStat(), '1.2M');
    expect(999999999.formattingToStat(), '999.9M');
    expect(9999999999.formattingToStat(), '9.9B');
  });
}
