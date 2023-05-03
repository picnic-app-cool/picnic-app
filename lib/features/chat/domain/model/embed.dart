import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/embed_status.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';

class Embed extends Equatable {
  const Embed({
    required this.id,
    required this.status,
    required this.linkMetaData,
  });

  const Embed.empty()
      : id = const Id.empty(),
        status = EmbedStatus.error,
        linkMetaData = const LinkMetadata.empty();

  final Id id;
  final EmbedStatus status;
  final LinkMetadata linkMetaData;

  @override
  List<Object?> get props => [
        id,
        status,
        linkMetaData,
      ];

  Embed copyWith({
    Id? id,
    EmbedStatus? status,
    LinkMetadata? linkMetaData,
  }) {
    return Embed(
      id: id ?? this.id,
      status: status ?? this.status,
      linkMetaData: linkMetaData ?? this.linkMetaData,
    );
  }
}
