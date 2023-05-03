import 'package:picnic_app/core/data/graphql/model/gql_link_metadata.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/embed.dart';
import 'package:picnic_app/features/chat/domain/model/embed_status.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlEmbed {
  const GqlEmbed({
    required this.id,
    required this.status,
    required this.linkMetadata,
  });

  factory GqlEmbed.fromJson(Map<String, dynamic>? json) {
    return GqlEmbed(
      id: asT<String>(json, 'id'),
      status: asT<String>(json, 'status'),
      linkMetadata: GqlLinkMetadata.fromJson(
        asT<Map<String, dynamic>>(json, 'linkMetaData'),
      ),
    );
  }

  final String id;
  final String status;
  final GqlLinkMetadata linkMetadata;

  Embed toDomain() => Embed(
        id: Id(id),
        status: EmbedStatus.fromString(status),
        linkMetaData: linkMetadata.toDomain(),
      );
}
