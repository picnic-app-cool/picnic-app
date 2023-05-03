import 'package:picnic_app/features/profile/edit_profile/edit_profile_navigator.dart';

class DesktopEditProfileNavigator extends EditProfileNavigator {
  DesktopEditProfileNavigator(super.appNavigator);

  @override
  Future<String?> showImageEditor({required String filePath, bool forceCrop = false}) async {
    return filePath;
  }
}
