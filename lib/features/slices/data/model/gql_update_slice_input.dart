import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';
import 'package:picnic_app/core/domain/model/slice_update_input.dart';
import 'package:picnic_app/utils/extensions/string_extensions.dart';

extension GqlUpdateSliceInput on SliceUpdateInput {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image.isNotEmpty
          ? GraphQLFileVariable(
              filePath: image,
              maximumAllowedFileSize: UploadFileSize.sliceImage,
            )
          : '',
      'private': private,
      'discoverable': discoverable,
      'rules': rules,
    }..removeWhere((key, value) => value == null || isNullOrEmptyString(value));
  }
}
