import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';

class SellSeedsSecondStepInitialParams {
  const SellSeedsSecondStepInitialParams({
    required this.seed,
    required this.onTransferSeedsCallback,
  });

  final Seed seed;
  final VoidCallback? onTransferSeedsCallback;
}
