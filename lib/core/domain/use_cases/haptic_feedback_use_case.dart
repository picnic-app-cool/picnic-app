import 'package:picnic_app/core/domain/repositories/haptic_repository.dart';

class HapticFeedbackUseCase {
  const HapticFeedbackUseCase(this._hapticRepository);

  final HapticRepository _hapticRepository;

  Future<void> execute() => _hapticRepository.lightImpact();
}
