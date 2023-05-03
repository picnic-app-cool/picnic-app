import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';

//ignore_for_file: unused-code, unused-files
class SoundAttachmentNavigator with CloseWithResultRoute<Sound> {
  SoundAttachmentNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SoundAttachmentRoute {
  Future<Sound?> openSoundAttachment(SoundAttachmentInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<SoundAttachmentPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
