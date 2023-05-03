import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/app_init_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AppInitPresentationModel implements AppInitViewModel {
  /// Creates the initial state
  AppInitPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AppInitInitialParams initialParams,
  )   : appInitResult = const FutureResult.empty(),
        user = const PrivateProfile.empty();

  /// Used for the copyWith method
  AppInitPresentationModel._({
    required this.user,
    required this.appInitResult,
  });

  final FutureResult<Either<AppInitFailure, Unit>> appInitResult;
  final PrivateProfile user;

  bool get isUserLoggedIn => !user.user.isAnonymous;

  AppInitPresentationModel copyWith({
    FutureResult<Either<AppInitFailure, Unit>>? appInitResult,
    PrivateProfile? user,
  }) {
    return AppInitPresentationModel._(
      appInitResult: appInitResult ?? this.appInitResult,
      user: user ?? this.user,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class AppInitViewModel {}
