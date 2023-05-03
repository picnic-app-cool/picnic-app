import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content_input.dart';

class GqlVideoPostContentInput {
  GqlVideoPostContentInput({
    required this.file,
    required this.text,
  });

  factory GqlVideoPostContentInput.fromDomain(VideoPostContentInput input) {
    return GqlVideoPostContentInput(
      file: GraphQLFileVariable(
        filePath: input.videoFilePath,
        maximumAllowedFileSize: UploadFileSize.videoPostContent,
      ),
      text: input.text,
    );
  }

  final GraphQLFileVariable file;
  final String text;

  Map<String, dynamic> toJson() {
    return {
      'videoFile': file,
      'text': text,
    };
  }
}
