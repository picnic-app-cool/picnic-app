import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class BanUserInitialParams {
  const BanUserInitialParams({required this.user, required this.circleId});

  final MinimalPublicProfile user;
  final Id circleId;
}
