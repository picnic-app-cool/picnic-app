import 'package:picnic_app/features/chat/domain/model/id.dart';

class FollowersInitialParams {
  const FollowersInitialParams({
    this.userId = const Id.empty(),
  });

  final Id userId;
}
