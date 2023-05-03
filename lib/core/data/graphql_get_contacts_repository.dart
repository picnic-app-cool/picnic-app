import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/contacts_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/contacts/gql_phone_contact.dart';
import 'package:picnic_app/core/data/graphql/model/gql_notify_meta_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user_contact.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user_mention.dart';
import 'package:picnic_app/core/data/model/to_phone_contact_extension.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_user_contact_failure.dart';
import 'package:picnic_app/core/domain/model/mention_user_failure.dart';
import 'package:picnic_app/core/domain/model/notify_contact_failure.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/core/domain/model/notify_type.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/upload_contacts_failure.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/domain/repositories/contacts_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GraphQlGetContactsRepository implements ContactsRepository {
  const GraphQlGetContactsRepository(
    this._gqlClient,
  );

  final GraphQLClient _gqlClient;

  @override
  Future<Either<GetUserContactFailure, PaginatedList<UserContact>>> getSavedContacts({
    Cursor? nextPageCursor,
    required String? searchQuery,
  }) =>
      _gqlClient
          .query(
            document: getUserContactsQuery,
            variables: {
              'searchQuery': searchQuery,
            },
            parseData: (json) {
              final data = json['getUserContacts'] as Map<String, dynamic>;
              return data;
            },
          )
          .mapFailure((fail) => const GetUserContactFailure.unknown())
          .mapSuccess((json) {
        final contact = asList(
          json,
          'contacts',
          GqlUserContact.fromJson,
        );

        //TODO (GS-6210): BE will return paginated list : remove when done : https://picnic-app.atlassian.net/browse/GS-6210
        return PaginatedList.singlePage(
          contact.map((contact) => contact.toDomain()).toList(),
        );
      });

  @override
  Future<List<PhoneContact>> getContacts() async {
    final contacts = await ContactsService.getContacts();
    return contacts.map((e) => e.toPhoneContact()).toList();
  }

  @override
  Future<Either<UploadContactsFailure, Unit>> uploadContacts({required List<PhoneContact> contacts}) => _gqlClient
      .mutate(
        document: uploadContactsMutation,
        parseData: (json) => GqlSuccessPayload.fromJson(json['addUserContacts'] as Map<String, dynamic>),
        variables: {
          'contacts': contacts.map((e) => e.toJson()).toList(),
        },
      )
      .mapFailure(UploadContactsFailure.unknown)
      .mapSuccessPayload(onFailureReturn: const UploadContactsFailure.unknown());

  @override
  Future<Either<NotifyContactFailure, Unit>> notifyContact({
    required Id contactId,
    required Id? entityId,
    required NotifyType notifyType,
  }) {
    return _gqlClient
        .mutate(
          document: notifyContactMutation,
          variables: {
            'contactID': contactId.value,
            'entityID': entityId?.value,
            'notifyType': notifyType,
          },
          parseData: (json) => GqlSuccessPayload.fromJson(json['notifyContact'] as Map<String, dynamic>),
        )
        .mapFailure(NotifyContactFailure.unknown)
        .mapSuccessPayload(onFailureReturn: const NotifyContactFailure.unknown());
  }

  @override
  Future<Either<MentionUserFailure, PaginatedList<UserMention>>> getUserMentions({
    required String searchQuery,
    required NotifyMeta? notifyMeta,
  }) {
    return _gqlClient
        .query(
          document: getUserMentionsQuery,
          variables: {
            'searchQuery': searchQuery,
            'meta': notifyMeta?.toGqlMetaInput().toJson(),
          },
          parseData: (json) {
            final data = json['userMentionsConnection'] as Map<String, dynamic>;
            return GqlConnection.fromJson(data);
          },
        )
        .mapFailure(
          (fail) => const MentionUserFailure.unknown(),
        )
        .mapSuccess(
          (connection) => connection.toDomain(
            nodeMapper: (node) => GqlUserMention.fromJson(node).toDomain(),
          ),
        );
  }
}
