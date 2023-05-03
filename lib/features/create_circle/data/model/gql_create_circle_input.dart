import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/utils/extensions/string_extensions.dart';

extension GqlCreateCircleInput on CircleInput {
  Map<String, dynamic> toJson() {
    return {
      'kind': moderationType.value,
      'name': name,
      'rulesText': rulesText,
      'description': description,
      'groupId': groupId.value,
      'image': userSelectedNewEmoji ? emoji : '',
      'imageFile': image.isNotEmpty && userSelectedNewImage
          ? GraphQLFileVariable(
              filePath: image,
              maximumAllowedFileSize: UploadFileSize.circleImage,
            )
          : '',
      'visibility': visibility.value,
      'coverImageFile': coverImage.isNotEmpty && userSelectedNewCoverImage
          ? GraphQLFileVariable(
              filePath: coverImage,
              maximumAllowedFileSize: UploadFileSize.circleImage,
            )
          : '',
      'options': configs.map((e) => e.toJson()).toList(),
    }..removeWhere((key, value) => value == null || isNullOrEmptyString(value));
  }
}

extension GqlCircleConfig on CircleConfig {
  Map<String, dynamic> toJson() {
    return {
      'name': type.value,
      'displayName': displayName,
      'emoji': emoji,
      'description': description,
      'value': enabled,
    }..removeWhere((key, value) => value == null || isNullOrEmptyString(value));
  }
}
