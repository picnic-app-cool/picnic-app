import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';

class GqlUserProfileImageInput {
  const GqlUserProfileImageInput({
    required this.profileImage,
  });

  final String profileImage;

  Map<String, dynamic> toJson() {
    return {
      'profileImage': GraphQLFileVariable(
        filePath: profileImage,
        maximumAllowedFileSize: UploadFileSize.profileImage,
      ),
    };
  }
}
