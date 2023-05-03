import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/contact_phone_number.dart';
import 'package:picnic_app/core/domain/model/user_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class UserMention extends Equatable {
  const UserMention({
    required this.id,
    required this.avatar,
    required this.name,
    required this.contactPhoneNumber,
    required this.userType,
    required this.followersCount,
  });

  const UserMention.anonymous()
      : id = const Id.empty(),
        avatar = '',
        name = '',
        contactPhoneNumber = const ContactPhoneNumber.empty(),
        userType = UserType.contact,
        followersCount = 0;

  const UserMention.empty() : this.anonymous();

  final Id id;
  final String avatar;
  final String name;
  final ContactPhoneNumber contactPhoneNumber;
  final UserType userType;
  final int followersCount;

  @override
  List<Object> get props => [
        id,
        avatar,
        name,
        contactPhoneNumber,
        userType,
        followersCount,
      ];

  bool get isAnonymous => id.isNone;

  UserMention copyWith({
    Id? id,
    String? name,
    String? avatar,
    ContactPhoneNumber? contactPhoneNumber,
    UserType? userType,
    int? followersCount,
  }) {
    return UserMention(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      contactPhoneNumber: contactPhoneNumber ?? this.contactPhoneNumber,
      userType: userType ?? this.userType,
      followersCount: followersCount ?? this.followersCount,
    );
  }
}
