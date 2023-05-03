import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_page.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class PollPostCreationNavigator with ImagePickerRoute, SoundAttachmentRoute, CreateCircleRoute {
  PollPostCreationNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PollPostCreationRoute {
  Future<void> openPollPostCreation(PollPostCreationInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<PollPostCreationPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
