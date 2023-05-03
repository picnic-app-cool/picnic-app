import 'package:picnic_app/features/slices/domain/model/accept_request_input.dart';

extension GqlAcceptRequestInput on AcceptRequestInput {
  Map<String, dynamic> toJson() {
    return {
      'sliceId': sliceId.value,
      'userRequestedToJoinID': userRequestedToJoinID.value,
    };
  }
}
