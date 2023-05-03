import 'package:imgly_sdk/imgly_sdk.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:video_editor_sdk/video_editor_sdk.dart';

mixin VideoEditorRoute {
  AppNavigator get appNavigator;

  Future<String?> editVideo(String path) async {
    final result = await VESDK.openEditor(Video(path), configuration: _createConfiguration());
    final resultPath = result?.video;
    if (resultPath == null) {
      return null;
    }

    return resultPath.substring('file://'.length);
  }

  Configuration _createConfiguration() {
    final configuration = Configuration(
      sticker: _stickerOptions(),
      audio: _audioOptions(),
      tools: [...Tool.values] //
        ..remove(Tool.audio), // TODO: Add audios
    );
    return configuration;
  }

  AudioOptions _audioOptions() {
    return AudioOptions(
      canvasActions: [
        AudioCanvasAction.playPause,
        AudioCanvasAction.delete,
      ],
    );
  }

  StickerOptions _stickerOptions() {
    const images = Assets.images;

    /// TODO: Add stickers according to the actual feature. This is just a test version of video editor
    final emoticons = StickerCategory.existing("imgly_sticker_category_emoticons");

    /// A customized predefined category.
    final shapes = StickerCategory.existing(
      "imgly_sticker_category_shapes",
      items: [
        Sticker.existing("imgly_sticker_shapes_badge_01"),
        Sticker.existing("imgly_sticker_shapes_arrow_02"),
      ],
    );

    final picnicLogo = images.picnicLogo.path;

    final flutterSticker = Sticker(
      "example_sticker_logos_flutter",
      "Flutter",
      picnicLogo,
    );

    /// A completely custom category.
    final logos = StickerCategory(
      "example_sticker_category_logos",
      "Logos",
      picnicLogo,
      items: [flutterSticker],
    );

    return StickerOptions(
      personalStickers: true,
      categories: [
        logos,
        emoticons,
        shapes,
      ],
    );
  }
}
