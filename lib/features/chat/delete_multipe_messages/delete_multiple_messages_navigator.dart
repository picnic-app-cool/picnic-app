import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_bottom_sheet.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_initial_params.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/date_time_picker_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class DeleteMultipleMessagesNavigator with CloseRoute, DateTimePickerRoute {
  DeleteMultipleMessagesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin DeleteMultipleMessagesRoute {
  Future<void> openDeleteMultipleMessagesBottomSheet(
    DeleteMultipleMessagesInitialParams initialParams,
  ) async {
    return showPicnicBottomSheet(
      getIt<DeleteMultipleMessagesBottomSheet>(param1: initialParams),
    );
  }
}
