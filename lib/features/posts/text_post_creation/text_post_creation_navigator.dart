import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_navigator.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class TextPostCreationNavigator with CreateCircleRoute, SoundAttachmentRoute {
  TextPostCreationNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin TextPostCreationRoute {
  Future<void> openTextPostCreation(TextPostCreationInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<TextPostCreationPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
