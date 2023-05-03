import 'package:equatable/equatable.dart';

//ignore_for_file: unused-code, unused-files
class PrivacySettings extends Equatable {
  const PrivacySettings({
    required this.directMessagesFromAccountsYouFollow,
    this.accessListOfContacts = false,
  });

  const PrivacySettings.empty()
      : directMessagesFromAccountsYouFollow = false,
        accessListOfContacts = false;

  final bool directMessagesFromAccountsYouFollow;
  final bool accessListOfContacts;

  @override
  List<Object?> get props => [
        directMessagesFromAccountsYouFollow,
        accessListOfContacts,
      ];

  PrivacySettings copyWith({
    bool? directMessagesFromAccountsYouFollow,
    bool? accessListOfContacts,
  }) {
    return PrivacySettings(
      directMessagesFromAccountsYouFollow:
          directMessagesFromAccountsYouFollow ?? this.directMessagesFromAccountsYouFollow,
      accessListOfContacts: accessListOfContacts ?? this.accessListOfContacts,
    );
  }
}
