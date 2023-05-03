import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql/model/gql_basic_public_profile.dart';
import 'package:picnic_app/core/data/graphql/model/gql_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';

void main() {
  test("BasicPublicProfile's 'iFollow' should be true if profile is myself", () {
    final publicProfile = GqlBasicPublicProfile.fromJson(userJson);

    expect(publicProfile.toDomain(Mocks.userStore).iFollow, true);
  });

  test("PublicProfile's 'iFollow' should be true if profile is myself", () {
    final publicProfile = GqlPublicProfile.fromJson(userJson);

    expect(publicProfile.toDomain(Mocks.userStore).iFollow, true);
  });

  setUp(
    () {
      when(() => Mocks.userStore.isMe(const Id(userId))).thenReturn(true);
    },
  );
}

const userId = "fdfeb710-c4c0-446e-8ccd-321db2f4d8c3";
final userJson = {
  "id": userId,
  "username": "chat user3",
  "fullName": "chat user3",
  "bio": "",
  "followers": 7,
  "likes": 0,
  "views": 0,
  "isFollowing": false,
  "profileImage": "https://media-stg.picnicgcp.net/profile/picnic_thumb.jpg",
  "isVerified": false,
  "age": 500,
  "phone": "+90 546 530 xx xx",
  "email": "3434",
  "languages": ["PL", "RU", "FR"]
};
