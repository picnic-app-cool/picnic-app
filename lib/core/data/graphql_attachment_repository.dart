import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picnic_app/core/data/graphql/attachment_queries.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_attachment.dart';
import 'package:picnic_app/core/data/graphql/model/gql_attachment_input.dart';
import 'package:picnic_app/core/data/hive/hive_client_primitive.dart';
import 'package:picnic_app/core/data/hive/hive_client_primitive_factory.dart';
import 'package:picnic_app/core/domain/model/blur_attachment_failure.dart';
import 'package:picnic_app/core/domain/model/get_is_blurred_attachment_failure.dart';
import 'package:picnic_app/core/domain/model/upload_attachment.dart';
import 'package:picnic_app/core/domain/model/upload_attachment_failure.dart';
import 'package:picnic_app/core/domain/model/video_thumbnail_failure.dart';
import 'package:picnic_app/core/domain/repositories/attachment_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GraphqlAttachmentRepository with FutureRetarder implements AttachmentRepository {
  const GraphqlAttachmentRepository(
    this._gqlClient,
    this._hiveClientPrimitiveFactory,
  );

  final GraphQLClient _gqlClient;
  final HiveClientPrimitiveFactory _hiveClientPrimitiveFactory;

  static const _attachmentUnBlurBox = 'attachmentUnBlurBox';

  HiveClientPrimitive<String, bool> get attachmentBlurHiveClient => _hiveClientPrimitiveFactory.createClient(
        boxName: _attachmentUnBlurBox,
      );

  @override
  Future<Either<UploadAttachmentFailure, Attachment>> uploadAttachment({
    required UploadAttachment attachment,
  }) =>
      _gqlClient
          .mutate(
            document: uploadAttachmentMutation,
            variables: {
              'file': GqlAttachmentInput(
                filePath: attachment.filePath,
                maximumAllowedFileSize: attachment.maximumAllowedFileSize,
              ).toJson(),
            },
            parseData: (json) => GqlAttachment.fromJson(
              json['uploadAttachment'] as Map<String, dynamic>,
            ).toDomain(),
          )
          .mapFailure(UploadAttachmentFailure.unknown);

  @override
  Future<Either<BlurAttachmentFailure, Unit>> unBlurAttachment({required Id attachmentId}) =>
      attachmentBlurHiveClient //
          .save(attachmentId.value, false)
          .mapFailure(BlurAttachmentFailure.unknown);

  @override
  Future<Either<GetIsBlurredAttachmentFailure, bool>> getIsBlurredAttachment({required Id attachmentId}) =>
      attachmentBlurHiveClient
          .read(attachmentId.value)
          .mapFailure(GetIsBlurredAttachmentFailure.unknown)
          .mapSuccess((isBlurred) => isBlurred ?? false);

  @override
  Future<Either<VideoThumbnailFailure, String>> getThumbnail({
    required File video,
    required int maxHeight,
    required int quality,
  }) async {
    final filePath = await VideoThumbnail.thumbnailFile(
      video: video.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: maxHeight,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    if (filePath != null) {
      return Future.value(success(filePath));
    }
    return Future.value(failure(const VideoThumbnailFailure.unknown()));
  }
}
