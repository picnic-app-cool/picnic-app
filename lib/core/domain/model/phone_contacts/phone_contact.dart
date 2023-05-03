//ignore_for_file: forbidden_import_in_domain, nullable_field_in_domain_entity
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact_data.dart';

class PhoneContact extends Equatable {
  const PhoneContact({
    required this.displayName,
    required this.familyName,
    required this.hasJobTitle,
    required this.phones,
    required this.avatar,
  });

  PhoneContact.empty()
      : displayName = '',
        familyName = '',
        hasJobTitle = false,
        phones = [],
        avatar = null;

  final String displayName;
  final String familyName;
  final Uint8List? avatar;
  final bool hasJobTitle;
  final List<PhoneContactData> phones;

  @override
  List<Object?> get props => [
        displayName,
        familyName,
        avatar,
        hasJobTitle,
        phones,
      ];

  PhoneContact copyWith({
    String? displayName,
    String? familyName,
    Uint8List? avatar,
    bool? hasJobTitle,
    List<PhoneContactData>? phones,
  }) {
    return PhoneContact(
      displayName: displayName ?? this.displayName,
      familyName: familyName ?? this.familyName,
      avatar: avatar ?? this.avatar,
      hasJobTitle: hasJobTitle ?? this.hasJobTitle,
      phones: phones ?? this.phones,
    );
  }
}
