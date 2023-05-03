import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class Sound extends Equatable {
  const Sound({
    required this.id,
    required this.title,
    required this.creator,
    required this.icon,
    required this.url,
    required this.usesCount,
    required this.duration,
  });

  const Sound.empty()
      : id = const Id.empty(),
        title = '',
        creator = '',
        icon = const ImageUrl.empty(),
        url = '',
        usesCount = 0,
        duration = Duration.zero;

  final Id id;
  final String title;
  final String creator;
  final ImageUrl icon;
  final String url;
  final int usesCount;
  final Duration duration;

  @override
  List<Object?> get props => [
        id,
        title,
        creator,
        icon,
        url,
        usesCount,
        duration,
      ];

  Sound copyWith({
    Id? id,
    String? title,
    String? creator,
    ImageUrl? icon,
    String? url,
    int? usesCount,
    Duration? duration,
  }) {
    return Sound(
      id: id ?? this.id,
      title: title ?? this.title,
      creator: creator ?? this.creator,
      icon: icon ?? this.icon,
      url: url ?? this.url,
      usesCount: usesCount ?? this.usesCount,
      duration: duration ?? this.duration,
    );
  }
}
