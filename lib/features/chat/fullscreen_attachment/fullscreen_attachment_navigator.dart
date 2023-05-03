import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_initial_params.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';

class FullscreenAttachmentNavigator with CloseRoute {
  const FullscreenAttachmentNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin FullscreenAttachmentRoute {
  Future<void> openFullscreenAttachment(FullscreenAttachmentInitialParams initialParams) async {
    return appNavigator.push(
      fadeInRoute(getIt<FullscreenAttachmentPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
