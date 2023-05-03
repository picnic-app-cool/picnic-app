class Durations {
  static const long = 500;
  static const medium = 300;
  static const short = 150;
  static const extraShort = 80;
}

class LongDuration extends Duration {
  const LongDuration() : super(milliseconds: Durations.long);
}

class MediumDuration extends Duration {
  const MediumDuration() : super(milliseconds: Durations.medium);
}

class ShortDuration extends Duration {
  const ShortDuration() : super(milliseconds: Durations.short);
}

class ExtraShortDuration extends Duration {
  const ExtraShortDuration() : super(milliseconds: Durations.extraShort);
}
