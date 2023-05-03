import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/download_failure.dart';

abstract class DownloadRepository {
  Future<Either<DownloadFailure, String>> download({required String url});
}
