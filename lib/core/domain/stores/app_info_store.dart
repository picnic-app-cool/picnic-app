import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';

class AppInfoStore extends Cubit<AppInfo> {
  AppInfoStore({AppInfo? appInfo}) : super(appInfo ?? const AppInfo.empty());

  AppInfo get appInfo => state;

  set appInfo(AppInfo appInfo) {
    tryEmit(appInfo);
  }
}
