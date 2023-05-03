import 'dart:io';

import 'package:dartz/dartz.dart';
import "package:dio/dio.dart" as dio;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:mime/mime.dart' as mime;
import 'package:picnic_app/core/data/graphql/graphql_custom_variable.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

//ignore_for_file: unused-code, unused-files
/// Transforms [File] to GraphQL variable and checks file size.
class GraphQLFileVariable implements GraphQLCustomVariable {
  const GraphQLFileVariable({
    required this.filePath,
    required this.maximumAllowedFileSize,
  });

  final String filePath;
  final UploadFileSize maximumAllowedFileSize;

  @override
  Future<Either<GraphQLFailure, dynamic>> getGraphQLVariable() async {
    final fileLength = await File(filePath).length();
    if (fileLength > maximumAllowedFileSize.size) {
      return failure(const GraphQLFailure.fileSizeTooBig());
    }

    final filename = filePath.split('/').last;

    final multipartFile = await dio.MultipartFile.fromFile(
      filePath,
      filename: filename,
      contentType: _retrieveMediaType(filename),
    );

    return success(multipartFile);
  }

  http_parser.MediaType? _retrieveMediaType(String filename) {
    final mimeType = mime.lookupMimeType(filename);
    return mimeType == null ? null : http_parser.MediaType.parse(mimeType);
  }
}
