import 'package:picnic_app/core/utils/utils.dart';

import 'package:picnic_app/features/chat/domain/model/id.dart';

class SellSeedsInitialParams {
  const SellSeedsInitialParams({
    this.onTransferSeedsCallback,
    this.circleId,
  });

  final VoidCallback? onTransferSeedsCallback;
  final Id? circleId;
}
