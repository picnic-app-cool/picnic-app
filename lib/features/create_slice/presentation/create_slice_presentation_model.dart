import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/slice_update_input.dart';
import 'package:picnic_app/core/domain/model/update_slice_failure.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/create_slice/domain/model/create_slice_failure.dart';
import 'package:picnic_app/features/create_slice/domain/model/create_slice_form.dart';
import 'package:picnic_app/features/create_slice/domain/model/slice_input.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CreateSlicePresentationModel implements CreateSliceViewModel {
  /// Creates the initial state
  CreateSlicePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CreateSliceInitialParams initialParams,
  )   : circle = initialParams.circle,
        sliceId = initialParams.slice?.id,
        isEditSlice = initialParams.isEditSlice,
        slice = initialParams.slice,
        createSliceForm = const CreateSliceForm.empty().copyWith(name: initialParams.slice?.name),
        createSliceFutureResult = const FutureResult.empty(),
        updateSliceFutureResult = const FutureResult.empty();

  /// Used for the copyWith method
  CreateSlicePresentationModel._({
    required this.createSliceFutureResult,
    required this.updateSliceFutureResult,
    required this.createSliceForm,
    required this.circle,
    required this.slice,
    required this.sliceId,
    required this.isEditSlice,
  });

  @override
  final CreateSliceForm createSliceForm;

  @override
  final Circle circle;

  @override
  final Slice? slice;

  @override
  final Id? sliceId;

  @override
  final bool isEditSlice;

  final FutureResult<Either<CreateSliceFailure, Slice>> createSliceFutureResult;

  final FutureResult<Either<UpdateSliceFailure, Slice>> updateSliceFutureResult;

  @override
  bool get isCreatingSliceLoading => createSliceFutureResult.isPending();

  @override
  bool get createSliceEnabled => createSliceForm.isValid;

  @override
  String get title => isEditSlice ? appLocalizations.editSliceTitle : appLocalizations.createSliceTitle;

  @override
  String get actionButtonLabel =>
      isEditSlice ? appLocalizations.editCircleButtonLabel : appLocalizations.createSliceTitle;

  SliceInput get createSliceInput => createSliceForm.toCreateSliceInput(circleId: circle.id);

  SliceUpdateInput? get updateSliceInput => slice?.toSliceUpdateInput();

  CreateSliceViewModel byUpdatingForm(CreateSliceForm Function(CreateSliceForm input) updater) {
    return copyWith(createSliceForm: updater(createSliceForm));
  }

  CreateSlicePresentationModel copyWith({
    CreateSliceForm? createSliceForm,
    Circle? circle,
    Id? sliceId,
    Slice? slice,
    FutureResult<Either<CreateSliceFailure, Slice>>? createSliceFutureResult,
    FutureResult<Either<UpdateSliceFailure, Slice>>? updateSliceFutureResult,
    bool? isEditSlice,
  }) {
    return CreateSlicePresentationModel._(
      isEditSlice: isEditSlice ?? this.isEditSlice,
      createSliceForm: createSliceForm ?? this.createSliceForm,
      circle: circle ?? this.circle,
      sliceId: sliceId ?? this.sliceId,
      createSliceFutureResult: createSliceFutureResult ?? this.createSliceFutureResult,
      updateSliceFutureResult: updateSliceFutureResult ?? this.updateSliceFutureResult,
      slice: slice ?? this.slice,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CreateSliceViewModel {
  CreateSliceForm get createSliceForm;

  bool get isCreatingSliceLoading;

  bool get createSliceEnabled;

  Circle get circle;

  Id? get sliceId;

  bool get isEditSlice;

  String get title;

  String get actionButtonLabel;

  Slice? get slice;
}
