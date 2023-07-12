import 'package:picnic_app/core/domain/model/get_recommended_chats_input.dart';

extension GqlGetRecommendedChatsContext on GetRecommendedChatsContext {
  Map<String, dynamic> toJson() {
    return {
      if (appId.isNotEmpty) 'appId': appId,
      if (postId.isNotEmpty) 'postId': postId,
      if (userId.isNotEmpty) 'userId': userId,
      if (circleId.isNotEmpty) 'circleId': circleId,
    };
  }
}
