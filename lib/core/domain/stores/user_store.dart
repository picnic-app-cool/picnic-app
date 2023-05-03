import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class UserStore extends Cubit<PrivateProfile> {
  UserStore({PrivateProfile? privateProfile}) : super(privateProfile ?? const PrivateProfile.empty());

  PrivateProfile get privateProfile => state;

  bool get isUserLoggedIn => !state.user.isAnonymous;

  set privateProfile(PrivateProfile privateProfile) {
    tryEmit(privateProfile);
  }

  bool isMe(Id userId) => privateProfile.isSameUser(userId: userId);
}
