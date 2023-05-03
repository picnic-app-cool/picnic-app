import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer_input.dart';

class GqlPollAnswerInput {
  const GqlPollAnswerInput({
    required this.answerType,
    required this.imageFile,
  });

  factory GqlPollAnswerInput.fromDomain(PollAnswerInput input) => GqlPollAnswerInput(
        answerType: input.answerType.stringVal,
        imageFile: GraphQLFileVariable(
          filePath: input.imagePath,
          maximumAllowedFileSize: UploadFileSize.imagePostContent,
        ),
      );

  final String answerType;
  final GraphQLFileVariable imageFile;

  Map<String, dynamic> toJson() => {
        'answerType': answerType,
        'imageContent': imageFile,
      };
}
