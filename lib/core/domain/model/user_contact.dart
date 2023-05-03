import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/contact_phone_number.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class UserContact extends Equatable {
  const UserContact({
    required this.id,
    required this.name,
    required this.invited,
    required this.contactPhoneNumber,
  });

  const UserContact.anonymous()
      : id = const Id(''),
        invited = false,
        name = '',
        contactPhoneNumber = const ContactPhoneNumber.empty();

  const UserContact.empty() : this.anonymous();

  final Id id;
  final String name;
  final bool invited;
  final ContactPhoneNumber contactPhoneNumber;

  @override
  List<Object> get props => [
        id,
        name,
        invited,
        contactPhoneNumber,
      ];

  bool get isAnonymous => id.isNone;

  UserContact copyWith({
    Id? id,
    String? name,
    bool? invited,
    ContactPhoneNumber? contactPhoneNumber,
  }) {
    return UserContact(
      id: id ?? this.id,
      name: name ?? this.name,
      invited: invited ?? this.invited,
      contactPhoneNumber: contactPhoneNumber ?? this.contactPhoneNumber,
    );
  }
}
