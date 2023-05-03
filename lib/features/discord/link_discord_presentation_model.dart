import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discord/link_discord_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LinkDiscordPresentationModel implements LinkDiscordViewModel {
  /// Creates the initial state
  LinkDiscordPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LinkDiscordInitialParams initialParams,
  )   : webhookUrl = '',
        urlShouldAutoComplete = false,
        serverIsConnected = false,
        circleId = initialParams.circleId;

  /// Used for the copyWith method
  LinkDiscordPresentationModel._({
    required this.webhookUrl,
    required this.urlShouldAutoComplete,
    required this.serverIsConnected,
    required this.circleId,
  });

  @override
  final String webhookUrl;

  @override
  final bool urlShouldAutoComplete;

  @override
  final bool serverIsConnected;

  final Id circleId;

  @override
  bool get isButtonEnabled => serverIsConnected || webhookUrl.isNotEmpty;

  LinkDiscordPresentationModel copyWith({
    String? webhookUrl,
    bool? urlShouldAutoComplete,
    bool? serverIsConnected,
    Id? circleId,
  }) {
    return LinkDiscordPresentationModel._(
      webhookUrl: webhookUrl ?? this.webhookUrl,
      urlShouldAutoComplete: urlShouldAutoComplete ?? this.urlShouldAutoComplete,
      serverIsConnected: serverIsConnected ?? this.serverIsConnected,
      circleId: circleId ?? this.circleId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LinkDiscordViewModel {
  String get webhookUrl;

  bool get urlShouldAutoComplete;

  bool get serverIsConnected;

  bool get isButtonEnabled;
}
