import 'package:picnic_app/features/profile/domain/private_profile_tab.dart';

class PrivateProfileInitialParams {
  const PrivateProfileInitialParams({
    this.initialTab = PrivateProfileTab.posts,
  });

  final PrivateProfileTab initialTab;
}
