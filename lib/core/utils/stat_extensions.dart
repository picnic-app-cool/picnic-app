extension StatExtensions on int {
  static const int _thousand = 1000;
  static const int _million = 1000000;
  static const int _billion = 1000000000;

  static const List<String> _thousandPow = [
    'K',
    'M',
    'B',
  ];

  String formattingToStat() {
    final value = this;

    if (value >= _billion) {
      final number = value ~/ _billion;
      final remainder = value % _billion;
      return _concatenateResult(
        number: number,
        remainder: remainder,
        postfix: _thousandPow[2],
      );
    }
    if (value >= _million) {
      final number = value ~/ _million;
      final remainder = value % _million;
      return _concatenateResult(
        number: number,
        remainder: remainder,
        postfix: _thousandPow[1],
      );
    }

    if (value >= _thousand) {
      final number = value ~/ _thousand;
      final remainder = value % _thousand;
      return _concatenateResult(
        number: number,
        remainder: remainder,
        postfix: _thousandPow.first,
      );
    }

    return value.toString();
  }

  String _concatenateResult({
    required int number,
    required int remainder,
    required String postfix,
  }) {
    if (remainder == 0) {
      return number.toString() + postfix;
    }
    final croppedRemainder = remainder.toString()[0];
    return '$number.$croppedRemainder$postfix';
  }
}
