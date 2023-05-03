import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picnic_app/core/domain/model/download_failure.dart';
import 'package:picnic_app/core/domain/repositories/download_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class DioDownloadRepository implements DownloadRepository {
  @override
  Future<Either<DownloadFailure, String>> download({required String url}) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final extName = Uri.parse(url).pathSegments.last.split('.').last;
      final fileName = basename(url);
      final savePath = '${tempDir.path}/$fileName.$extName';
      final dio = Dio();
      await dio.download(url, savePath);
      return success(savePath);
    } catch (ex) {
      return failure(DownloadFailure.unknown(ex));
    }
  }
}
