import 'package:picnic_app/features/chat/domain/model/id.dart';

class SeedHoldersInitialParams {
  const SeedHoldersInitialParams({
    this.circleId = const Id.empty(),
    this.isSeedHolder = false,
  });

  final Id circleId;
  final bool isSeedHolder;
}
