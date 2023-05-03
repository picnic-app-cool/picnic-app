import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/slice_update_input.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class EditSliceRulesPresentationModel implements EditSliceRulesViewModel {
  /// Creates the initial state
  EditSliceRulesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    EditSliceRulesInitialParams initialParams,
  ) : slice = initialParams.slice;

  /// Used for the copyWith method
  EditSliceRulesPresentationModel._({
    required this.slice,
  });

  final Slice slice;

  @override
  String get rules => slice.rules;

  @override
  Id get sliceId => slice.id;

  SliceUpdateInput get sliceInput => slice.toSliceUpdateInput();

  EditSliceRulesViewModel byUpdatingRulesText(String rules) => copyWith(
        slice: slice.copyWith(rules: rules),
      );

  EditSliceRulesPresentationModel copyWith({
    Slice? slice,
  }) {
    return EditSliceRulesPresentationModel._(
      slice: slice ?? this.slice,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class EditSliceRulesViewModel {
  String get rules;

  Id get sliceId;
}
