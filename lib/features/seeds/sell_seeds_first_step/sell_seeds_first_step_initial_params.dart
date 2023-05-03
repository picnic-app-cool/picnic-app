import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';

class SellSeedsFirstStepInitialParams {
  const SellSeedsFirstStepInitialParams({
    required this.onChooseCircle,
    this.circleId,
  });

  final OnChooseCircle onChooseCircle;
  final Id? circleId;
}

typedef OnChooseCircle = void Function(Seed seed);
