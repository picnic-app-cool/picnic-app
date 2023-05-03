import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/get_user_roles_in_circle_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SingleChatSettingsPresentationModel implements SingleChatSettingsViewModel {
  /// Creates the initial state
  SingleChatSettingsPresentationModel.initial(
    SingleChatSettingsInitialParams initialParams,
  )   : followed = false,
        followMe = false,
        muted = false,
        followResult = const FutureResult.empty(),
        muteResult = const FutureResult.empty(),
        user = initialParams.user,
        chatId = initialParams.chatId,
        getUserResult = const FutureResult.pending(),
        getChatSettingsResult = const FutureResult.pending(),
        getUserRolesResult = const FutureResult.empty();

  /// Used for the copyWith method
  SingleChatSettingsPresentationModel._({
    required this.followed,
    required this.followMe,
    required this.muted,
    required this.followResult,
    required this.muteResult,
    required this.user,
    required this.chatId,
    required this.getUserResult,
    required this.getChatSettingsResult,
    required this.getUserRolesResult,
  });

  @override
  final bool followed;

  @override
  final bool followMe;

  @override
  final bool muted;

  @override
  final FutureResult<void> followResult;

  @override
  final FutureResult<void> muteResult;

  @override
  final User user;

  final Id chatId;

  final FutureResult<void> getUserResult;

  final FutureResult<void> getChatSettingsResult;

  final FutureResult<Either<GetUserRolesInCircleFailure, CircleMemberCustomRoles>> getUserRolesResult;

  @override
  bool get areRolesLoading => getUserRolesResult.isPending();

  @override
  bool get loading => getUserResult.isPending() && getChatSettingsResult.isPending();

  SingleChatSettingsPresentationModel copyWith({
    bool? followed,
    bool? followMe,
    bool? muted,
    FutureResult<void>? followResult,
    FutureResult<void>? muteResult,
    User? user,
    Id? chatId,
    FutureResult<void>? getUserResult,
    FutureResult<void>? getChatSettingsResult,
    FutureResult<Either<GetUserRolesInCircleFailure, CircleMemberCustomRoles>>? getUserRolesResult,
  }) {
    return SingleChatSettingsPresentationModel._(
      followed: followed ?? this.followed,
      followMe: followMe ?? this.followMe,
      muted: muted ?? this.muted,
      followResult: followResult ?? this.followResult,
      muteResult: muteResult ?? this.muteResult,
      user: user ?? this.user,
      chatId: chatId ?? this.chatId,
      getUserResult: getUserResult ?? this.getUserResult,
      getChatSettingsResult: getChatSettingsResult ?? this.getChatSettingsResult,
      getUserRolesResult: getUserRolesResult ?? this.getUserRolesResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SingleChatSettingsViewModel {
  bool get muted;

  bool get followed;

  bool get loading;

  bool get followMe;

  User get user;

  FutureResult<void> get muteResult;

  FutureResult<void> get followResult;

  bool get areRolesLoading;
}
