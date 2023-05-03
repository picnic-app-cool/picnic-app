import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_navigator.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_presentation_model.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/model/delete_multiple_messages_condition.dart';

class DeleteMultipleMessagesPresenter extends Cubit<DeleteMultipleMessagesViewModel> {
  DeleteMultipleMessagesPresenter(
    super.model,
    this.navigator,
  );

  final DeleteMultipleMessagesNavigator navigator;

  DeleteMultipleMessagesPresentationModel get _model => state as DeleteMultipleMessagesPresentationModel;

  void onTapDeleteMessages() {
    // TODO: Waiting BE - https://picnic-app.atlassian.net/browse/GS-6078
    // We need both close() to close:
    // - Bottom sheet with mass deletion options
    // - Chat message selection with other options
    navigator.close();
    navigator.close();
  }

  void onTapClose() {
    navigator.close();
  }

  void onTapConditionInput() {
    tryEmit(_model.copyWith(conditions: DeleteMultipleMessagesCondition.values));
  }

  void onTapConditionItem(DeleteMultipleMessagesCondition condition) {
    tryEmit(
      _model.copyWith(
        selectedCondition: condition,
        conditions: const [],
        isCustomTimeFrame: condition == DeleteMultipleMessagesCondition.customTimeFrame,
      ),
    );
  }

  Future<void> onTapDateTimeInput({bool isDateTimeFrom = false}) async {
    final dateTime = await navigator.openDateTimePickerRoute(currentTime: _model.currentTime);
    if (dateTime == null) {
      return;
    }
    if (isDateTimeFrom) {
      tryEmit(
        _model.copyWith(
          dateTimeFrom: dateTime,
        ),
      );
    }
    tryEmit(
      _model.copyWith(
        dateTimeTo: dateTime,
      ),
    );
  }
}
