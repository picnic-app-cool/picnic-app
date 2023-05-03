import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';

class GqlImagePostContentInput {
  GqlImagePostContentInput({
    required this.file,
    required this.text,
  });

  factory GqlImagePostContentInput.fromDomain(ImagePostContentInput input) {
    return GqlImagePostContentInput(
      text: input.text.trim(),
      file: GraphQLFileVariable(
        filePath: input.imageFilePath,
        maximumAllowedFileSize: UploadFileSize.videoPostContent,
      ),
    );
  }

  final GraphQLFileVariable file;
  final String text;

  Map<String, dynamic> toJson() {
    return {
      'imageFile': file,
      'text': text,
    };
  }
}
