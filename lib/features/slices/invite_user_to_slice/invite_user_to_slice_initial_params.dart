import 'package:picnic_app/features/chat/domain/model/id.dart';

class InviteUserToSliceInitialParams {
  const InviteUserToSliceInitialParams({
    required this.circleId,
    required this.sliceId,
  });

  final Id circleId;
  final Id sliceId;
}
