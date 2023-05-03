import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/check_username_availability_failure.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/username_check_result.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/validators/full_name_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/edit_profile_failure.dart';
import 'package:picnic_app/features/profile/domain/model/update_profile_image_failure.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class EditProfilePresentationModel implements EditProfileViewModel {
  /// Creates the initial state
  EditProfilePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    EditProfileInitialParams initialParams,
    this.usernameValidator,
    this.fullNameValidator,
  )   : username = initialParams.privateProfile.username,
        fullName = initialParams.privateProfile.fullName,
        bio = initialParams.privateProfile.bio,
        avatar = initialParams.privateProfile.profileImageUrl.url,
        privateProfile = initialParams.privateProfile,
        usernameCheckResult = const FutureResult.empty(),
        avatarResult = const FutureResult.empty(),
        editProfileResult = const FutureResult.empty(),
        userSelectedNewAvatar = false;

  /// Used for the copyWith method
  EditProfilePresentationModel._({
    required this.avatar,
    required this.avatarResult,
    required this.username,
    required this.fullName,
    required this.bio,
    required this.usernameCheckResult,
    required this.privateProfile,
    required this.usernameValidator,
    required this.fullNameValidator,
    required this.userSelectedNewAvatar,
    required this.editProfileResult,
  });

  final FutureResult<Either<CheckUsernameAvailabilityFailure, UsernameCheckResult>> usernameCheckResult;
  final FutureResult<Either<UpdateProfileImageFailure, ImageUrl>> avatarResult;
  final FutureResult<Either<EditProfileFailure, Unit>> editProfileResult;

  final UsernameValidator usernameValidator;

  final FullNameValidator fullNameValidator;

  @override
  final String avatar;

  @override
  final String username;

  @override
  final String fullName;

  @override
  final String? bio;

  @override
  final bool userSelectedNewAvatar;

  final PrivateProfile privateProfile;

  @override
  bool get saveEnabled =>
      !isLoadingAvatarUpload &&
      !isLoadingUsernameCheck &&
      !isLoadingEditProfile &&
      !_isTaken &&
      usernameValidator.validate(username).isSuccess &&
      fullNameValidator.validate(fullName).isSuccess &&
      profileInfoChanged;

  @override
  bool get isLoadingUsernameCheck => usernameCheckResult.isPending();

  @override
  bool get isLoadingAvatarUpload => avatarResult.isPending();

  @override
  bool get isLoadingEditProfile => editProfileResult.isPending();

  @override
  bool get containsSpaces =>
      userNameChanged &&
      usernameValidator.validate(username).getFailure()?.type == UsernameValidationErrorType.containsSpaces;

  @override
  String? get name => fullName.isEmpty ? username : fullName;

  @override
  bool get bioChanged => bio != privateProfile.bio;

  @override
  bool get fullNameChanged => fullName != privateProfile.user.fullName;

  @override
  bool get profileInfoChanged => bioChanged || fullNameChanged || userNameChanged || userSelectedNewAvatar;

  @override
  bool get userNameChanged => username != privateProfile.username;

  @override
  String get usernameErrorText {
    if (!userNameChanged) {
      return '';
    }
    final validationFailure = usernameValidator.validate(username).getFailure();
    if (validationFailure != null) {
      return validationFailure.errorText;
    }
    if (_isTaken) {
      return appLocalizations.usernameTakenErrorMessage;
    }
    return '';
  }

  @override
  String get fullNameErrorText {
    if (!fullNameChanged) {
      return '';
    }
    final validationFailure = fullNameValidator.validate(fullName).getFailure();
    if (validationFailure != null) {
      return validationFailure.errorText;
    }
    return '';
  }

  UsernameCheckResult? get _usernameCheckResult => usernameCheckResult.result?.getSuccess();

  bool get _isTaken => userNameChanged && (_usernameCheckResult?.isTaken ?? false);

  EditProfilePresentationModel copyWith({
    String? avatar,
    String? username,
    String? fullName,
    UsernameValidator? usernameValidator,
    FullNameValidator? fullNameValidator,
    String? bio,
    Id? id,
    FutureResult<Either<CheckUsernameAvailabilityFailure, UsernameCheckResult>>? usernameCheckResult,
    FutureResult<Either<UpdateProfileImageFailure, ImageUrl>>? avatarResult,
    bool? userSelectedNewAvatar,
    FutureResult<Either<EditProfileFailure, Unit>>? editProfileResult,
  }) =>
      EditProfilePresentationModel._(
        avatar: avatar ?? this.avatar,
        usernameValidator: usernameValidator ?? this.usernameValidator,
        fullNameValidator: fullNameValidator ?? this.fullNameValidator,
        avatarResult: avatarResult ?? this.avatarResult,
        username: username ?? this.username,
        fullName: fullName ?? this.fullName,
        bio: bio ?? this.bio,
        usernameCheckResult: usernameCheckResult ?? this.usernameCheckResult,
        privateProfile: privateProfile,
        userSelectedNewAvatar: userSelectedNewAvatar ?? this.userSelectedNewAvatar,
        editProfileResult: editProfileResult ?? this.editProfileResult,
      );
}

/// Interface to expose fields used by the view (page).
abstract class EditProfileViewModel {
  String get fullName;

  String? get name;

  String get username;

  bool get isLoadingUsernameCheck;

  bool get isLoadingAvatarUpload;

  bool get isLoadingEditProfile;

  bool get fullNameChanged;

  bool get bioChanged;

  bool get userNameChanged;

  String? get bio;

  bool get saveEnabled;

  bool get profileInfoChanged;

  bool get containsSpaces;

  String get usernameErrorText;

  String get fullNameErrorText;

  bool get userSelectedNewAvatar;

  String get avatar;
}
