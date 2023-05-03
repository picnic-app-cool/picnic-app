import 'package:picnic_app/core/domain/model/live_event/live_event.dart';
import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';

class StartUnreadChatsListeningUseCase {
  const StartUnreadChatsListeningUseCase(this._liveEventsRepository, this._userStore);

  final UserStore _userStore;
  final LiveEventsRepository _liveEventsRepository;

  Future<Stream<LiveEvent<ChatEvent>>> execute() =>
      _liveEventsRepository.startUnreadChatUpdateListening(_userStore.privateProfile.id);
}
