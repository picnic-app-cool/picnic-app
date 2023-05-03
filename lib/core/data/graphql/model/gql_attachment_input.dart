import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';

class GqlAttachmentInput {
  GqlAttachmentInput({
    required this.filePath,
    required this.maximumAllowedFileSize,
  });

  final String filePath;
  final UploadFileSize maximumAllowedFileSize;

  Map<String, dynamic> toJson() {
    return {
      'payload': GraphQLFileVariable(
        filePath: filePath,
        maximumAllowedFileSize: maximumAllowedFileSize,
      ),
    };
  }
}
