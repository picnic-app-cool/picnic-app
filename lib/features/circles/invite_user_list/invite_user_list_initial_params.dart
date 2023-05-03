import 'package:picnic_app/features/chat/domain/model/id.dart';

class InviteUserListInitialParams {
  const InviteUserListInitialParams({
    required this.circleId,
    this.sliceId,
  });

  final Id circleId;
  final Id? sliceId;
}
