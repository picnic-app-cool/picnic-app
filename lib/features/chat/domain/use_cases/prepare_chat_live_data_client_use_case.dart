import 'package:picnic_app/core/domain/live_data_client.dart';
import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';

class PrepareChatLiveDataClientUseCase {
  const PrepareChatLiveDataClientUseCase(this._chatLiveRepository);

  final LiveEventsRepository _chatLiveRepository;

  Future<LiveDataClient<ChatEvent>> execute() async {
    return _chatLiveRepository.getChatLiveDataClient();
  }
}
