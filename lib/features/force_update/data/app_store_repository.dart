import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:package_info_plus_platform_interface/package_info_platform_interface.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/force_update/domain/model/open_store_failure.dart';
import 'package:picnic_app/features/force_update/domain/repositories/store_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStoreRepository implements StoreRepository {
  const AppStoreRepository(this.packageInfoPlatform);

  final PackageInfoPlatform packageInfoPlatform;

  @override
  Future<Either<OpenStoreFailure, Unit>> openStore(String packageName) async {
    final url = Uri.parse(
      Platform.isIOS ? '${Constants.iOSUrl}$packageName' : '${Constants.androidUrl}$packageName',
    );

    return _launchUrl(url);
  }

  Future<Either<OpenStoreFailure, Unit>> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      return success(unit);
    } else {
      return failure(const OpenStoreFailure.cantLaunchUrl());
    }
  }
}
