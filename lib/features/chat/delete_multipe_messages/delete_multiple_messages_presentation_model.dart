import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_initial_params.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/model/delete_multiple_messages_condition.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DeleteMultipleMessagesPresentationModel implements DeleteMultipleMessagesViewModel {
  /// Creates the initial state
  DeleteMultipleMessagesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DeleteMultipleMessagesInitialParams initialParams,
    this.currentTimeProvider,
  )   : user = initialParams.user,
        selectedCondition = DeleteMultipleMessagesCondition.values.first,
        conditions = const [],
        isCustomTimeFrame = false,
        dateTimeFrom = currentTimeProvider.currentTime,
        dateTimeTo = currentTimeProvider.currentTime;

  /// Used for the copyWith method
  DeleteMultipleMessagesPresentationModel._({
    required this.user,
    required this.selectedCondition,
    required this.conditions,
    required this.currentTimeProvider,
    required this.isCustomTimeFrame,
    required this.dateTimeFrom,
    required this.dateTimeTo,
  });

  final CurrentTimeProvider currentTimeProvider;

  @override
  final User user;

  @override
  final DeleteMultipleMessagesCondition selectedCondition;

  @override
  final List<DeleteMultipleMessagesCondition> conditions;

  @override
  final bool isCustomTimeFrame;

  @override
  final DateTime dateTimeFrom;

  @override
  final DateTime dateTimeTo;

  DateTime get currentTime => currentTimeProvider.currentTime;

  DeleteMultipleMessagesPresentationModel copyWith({
    User? user,
    DeleteMultipleMessagesCondition? selectedCondition,
    List<DeleteMultipleMessagesCondition>? conditions,
    CurrentTimeProvider? currentTimeProvider,
    bool? isCustomTimeFrame,
    DateTime? dateTimeFrom,
    DateTime? dateTimeTo,
  }) {
    return DeleteMultipleMessagesPresentationModel._(
      user: user ?? this.user,
      selectedCondition: selectedCondition ?? this.selectedCondition,
      conditions: conditions ?? this.conditions,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      isCustomTimeFrame: isCustomTimeFrame ?? this.isCustomTimeFrame,
      dateTimeFrom: dateTimeFrom ?? this.dateTimeFrom,
      dateTimeTo: dateTimeTo ?? this.dateTimeTo,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DeleteMultipleMessagesViewModel {
  User get user;

  DeleteMultipleMessagesCondition get selectedCondition;

  List<DeleteMultipleMessagesCondition> get conditions;

  bool get isCustomTimeFrame;

  DateTime get dateTimeFrom;

  DateTime get dateTimeTo;
}
