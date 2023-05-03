import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/control_audio_play_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_sounds_list_use_case.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_navigator.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presentation_model.dart';

class SoundAttachmentPresenter extends Cubit<SoundAttachmentViewModel> {
  SoundAttachmentPresenter(
    super.model,
    this.navigator,
    this._getSoundsListUseCase,
    this._controlAudioPlayUseCase,
    this._debouncer,
  );

  final SoundAttachmentNavigator navigator;
  final GetSoundsListUseCase _getSoundsListUseCase;
  final ControlAudioPlayUseCase _controlAudioPlayUseCase;
  final Debouncer _debouncer;
  Sound? _lastPlayedSound;
  bool _isPlaying = false;

  SoundAttachmentPresentationModel get _model => state as SoundAttachmentPresentationModel;

  void onTextChanged(String text) {
    if (text != _model.textSearched) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          _controlAudioPlayUseCase.execute(action: AudioAction.stop);
          tryEmit(_model.copyWith(textSearched: text));
          loadMore(fromScratch: true);
        },
      );
    }
  }

  Future<void> onTapPlayPause(Sound sound) async {
    if (sound == _lastPlayedSound) {
      if (_isPlaying) {
        //PAUSE
        _isPlaying = false;
        _updateSounds();
        return _controlAudioPlayUseCase.execute(action: AudioAction.pause);
      } else {
        //RESUME
        _isPlaying = true;
        _updateSounds(nowPlaying: sound);
        return _controlAudioPlayUseCase.execute(action: AudioAction.resume);
      }
    } else {
      //PLAY NEW SOUND FROM START
      _isPlaying = true;
      _lastPlayedSound = sound;
      _updateSounds(nowPlaying: sound);
      return _controlAudioPlayUseCase.execute(action: AudioAction.play, soundUrl: sound.url);
    }
  }

  void onTapSelect({required Sound sound}) => navigator.closeWithResult(sound);

  @override
  Future<void> close() {
    _controlAudioPlayUseCase.execute(action: AudioAction.stop);
    return super.close();
  }

  Future<void> loadMore({bool fromScratch = false}) {
    if (fromScratch) {
      tryEmit(_model.copyWith(sounds: const PaginatedList.empty()));
    }
    return _getSoundsListUseCase
        .execute(
      searchQuery: _model.textSearched,
      cursor: _model.cursor,
    )
        .doOn(
      success: (list) {
        tryEmit(
          _model.byAppendingSoundsList(list),
        );
      },
    );
  }

  void _updateSounds({Sound? nowPlaying}) {
    tryEmit(
      _model.copyWith(
        sounds: PaginatedList(
          pageInfo: _model.sounds.pageInfo,
          items: _model.sounds.items.map(
            (playableSound) {
              return playableSound.copyWith(
                sound: playableSound.sound,
                isPlaying: playableSound.sound == nowPlaying,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
