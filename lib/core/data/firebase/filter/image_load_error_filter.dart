import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/data/firebase/filter/error_filter.dart';

/// Create a filter to [ImageLoadErrorFilter]
///
/// The error should be of type [HttpException] or [FlutterErrorDetails] and
/// whenever the [suppress] is satisfied it should return true.
///
/// Create a new [ErrorFilter] if you need to add more filters to decide when
/// log some error to FirebaseCrashlytics
class ImageLoadErrorFilter extends ErrorFilter {
  final statusCode403 = 'Invalid statusCode: 403';
  final statusCode404 = 'Invalid statusCode: 404';

  @override
  bool suppress(dynamic error) {
    if (error is HttpException &&
        (error.message.startsWith(statusCode403) || error.message.startsWith(statusCode404))) {
      return true;
    } else if (error is FlutterErrorDetails && error.library == 'image resource service') {
      final exception = error.exception.toString();

      if (error.exception is NetworkImageLoadException ||
          exception.contains(statusCode403) ||
          exception.contains(statusCode404)) {
        return true;
      }
    } else if (error is NetworkImageLoadException && error.statusCode == HttpStatus.notFound) {
      return true;
    }

    return false;
  }
}
