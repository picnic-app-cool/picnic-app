import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';

class VideoMuteStore extends Cubit<bool> {
  VideoMuteStore({bool? muted}) : super(muted ?? false);

  bool get muted => state;

  set muted(bool value) {
    tryEmit(value);
  }
}
