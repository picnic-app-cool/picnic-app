import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/slice.dart';

class SliceSettingsInitialParams {
  const SliceSettingsInitialParams({
    required this.circle,
    required this.slice,
  });

  final Circle circle;
  final Slice slice;
}
