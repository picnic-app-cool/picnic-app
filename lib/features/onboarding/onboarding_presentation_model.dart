import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/register_failure.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class OnboardingPresentationModel implements OnboardingViewModel {
  /// Creates the initial state
  OnboardingPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    OnboardingInitialParams initialParams,
  )   : flowType = OnboardingFlowType.none,
        screensList = [],
        user = const PrivateProfile.empty(),
        formData = const OnboardingFormData.empty(),
        registerFutureResult = const FutureResult.empty(),
        notificationsPermissionStatus = RuntimePermissionStatus.unknown,
        contactsPermissionStatus = RuntimePermissionStatus.unknown;

  /// Used for the copyWith method
  OnboardingPresentationModel._({
    required this.flowType,
    required this.screensList,
    required this.formData,
    required this.registerFutureResult,
    required this.notificationsPermissionStatus,
    required this.contactsPermissionStatus,
    required this.user,
  });

  final PrivateProfile user;
  final List<OnboardingScreen> screensList;
  final OnboardingFlowType flowType;
  final OnboardingFormData formData;
  final FutureResult<Either<RegisterFailure, PrivateProfile>> registerFutureResult;
  final RuntimePermissionStatus notificationsPermissionStatus;
  final RuntimePermissionStatus contactsPermissionStatus;

  static const _signUpScreensOrder = [
    OnboardingScreen.methods,
    OnboardingScreen.age,
    OnboardingScreen.phone,
    OnboardingScreen.codeVerification,
    OnboardingScreen.gender,
    OnboardingScreen.interests,
    OnboardingScreen.username,
    OnboardingScreen.permissions,
  ];

  static const _signInScreensOrder = [
    OnboardingScreen.methods,
    OnboardingScreen.phone,
    OnboardingScreen.codeVerification,
    OnboardingScreen.permissions,
  ];

  static const _signInScreensOrderDiscord = [
    OnboardingScreen.age,
    OnboardingScreen.gender,
    OnboardingScreen.permissions,
  ];

  @override
  bool get showPermissionsScreen =>
      (notificationsPermissionStatus != RuntimePermissionStatus.permanentlyDenied ||
          notificationsPermissionStatus != RuntimePermissionStatus.granted) &&
      (contactsPermissionStatus != RuntimePermissionStatus.permanentlyDenied ||
          contactsPermissionStatus != RuntimePermissionStatus.granted);

  OnboardingScreen? get nextScreen => screensList.firstOrNull;

  bool get hasNextScreen => screensList.isNotEmpty;

  OnboardingPresentationModel byGoingToNextScreen() {
    if (screensList.isNotEmpty) {
      return copyWith(
        screensList: List.unmodifiable([...screensList].sublist(1)),
      );
    }
    return this;
  }

  OnboardingPresentationModel byRemovingScreensFlow({
    List<OnboardingScreen> removeScreens = const [],
  }) {
    final List<OnboardingScreen> list;
    switch (flowType) {
      case OnboardingFlowType.none:
        list = [];
        break;
      case OnboardingFlowType.signUp:
        list = [..._signUpScreensOrder];
        break;
      case OnboardingFlowType.signIn:
        list = [..._signInScreensOrder];
        break;
      case OnboardingFlowType.discord:
        list = [..._signInScreensOrderDiscord];
        break;
    }
    for (final screen in removeScreens) {
      list.remove(screen);
    }
    return copyWith(
      flowType: flowType,
      screensList: List.unmodifiable(list),
    );
  }

  OnboardingPresentationModel bySelectingFlow(
    OnboardingFlowType flowType, {
    List<OnboardingScreen> removeScreens = const [],
  }) {
    final List<OnboardingScreen> list;
    switch (flowType) {
      case OnboardingFlowType.none:
        list = [];
        break;
      case OnboardingFlowType.signUp:
        list = [..._signUpScreensOrder];
        break;
      case OnboardingFlowType.signIn:
        list = [..._signInScreensOrder];
        break;
      case OnboardingFlowType.discord:
        list = [..._signInScreensOrderDiscord];
        break;
    }
    for (final screen in removeScreens) {
      list.remove(screen);
    }
    return copyWith(
      flowType: flowType,
      screensList: List.unmodifiable(list),
    );
  }

  OnboardingPresentationModel byUpdatingFormData(
    OnboardingFormData Function(OnboardingFormData) updater,
  ) =>
      copyWith(formData: updater(formData));

  OnboardingPresentationModel byRemovingScreen(OnboardingScreen screen) {
    return copyWith(
      screensList: List.unmodifiable([...screensList]..remove(screen)),
    );
  }

  OnboardingPresentationModel copyWith({
    List<OnboardingScreen>? screensList,
    OnboardingFlowType? flowType,
    OnboardingFormData? formData,
    FutureResult<Either<RegisterFailure, PrivateProfile>>? registerFutureResult,
    RuntimePermissionStatus? notificationsPermissionStatus,
    RuntimePermissionStatus? contactsPermissionStatus,
    PrivateProfile? user,
  }) {
    return OnboardingPresentationModel._(
      screensList: screensList ?? this.screensList,
      flowType: flowType ?? this.flowType,
      formData: formData ?? this.formData,
      registerFutureResult: registerFutureResult ?? this.registerFutureResult,
      notificationsPermissionStatus: notificationsPermissionStatus ?? this.notificationsPermissionStatus,
      contactsPermissionStatus: contactsPermissionStatus ?? this.contactsPermissionStatus,
      user: user ?? this.user,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class OnboardingViewModel {
  bool get showPermissionsScreen;
}

enum OnboardingFlowType {
  none,
  discord,
  signUp,
  signIn;
}

enum OnboardingScreen {
  methods,
  phone,
  language,
  age,
  codeVerification,
  username,
  permissions,
  gender,
  interests;
}
