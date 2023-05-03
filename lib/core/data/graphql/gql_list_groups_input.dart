import 'package:picnic_app/features/onboarding/domain/model/list_groups_input.dart';

extension GqlListGroupsInput on ListGroupsInput {
  Map<String, dynamic> toJson() {
    return {
      'isTrending': isTrending,
      'isWithCircles': isWithCircles,
    };
  }
}
