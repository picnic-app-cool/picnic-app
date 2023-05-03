import 'package:flutter/services.dart';
import 'package:picnic_app/core/domain/repositories/haptic_repository.dart';

class DeviceHapticRepository implements HapticRepository {
  const DeviceHapticRepository();

  @override
  Future<void> lightImpact() => HapticFeedback.lightImpact();
}
