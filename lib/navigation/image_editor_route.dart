import 'package:imgly_sdk/imgly_sdk.dart';
import 'package:photo_editor_sdk/photo_editor_sdk.dart';
import 'package:picnic_app/resources/assets.gen.dart';

mixin ImageEditorRoute {
  final flutterSticker = Sticker(
    "example_sticker_logos_flutter",
    "Flutter",
    Assets.images.picnicLogo.path,
  );
  final imglySticker = Sticker(
    "example_sticker_logos_imgly",
    "img.ly",
    Assets.images.watermelonWhole.path,
  );

  /// A completely custom category.
  StickerCategory get logos => StickerCategory(
        "example_sticker_category_logos",
        "Logos",
        Assets.images.picnicLogo.path,
        items: [
          flutterSticker,
          imglySticker,
        ],
      );

  /// A predefined category.
  final emoticons = StickerCategory.existing("imgly_sticker_category_emoticons");

  /// A customized predefined category.
  final shapes = StickerCategory.existing(
    "imgly_sticker_category_shapes",
    items: [
      Sticker.existing("imgly_sticker_shapes_badge_01"),
      Sticker.existing(
        "imgly_sticker_shapes_arrow_02",
      ),
    ],
  );

  List<StickerCategory> get categories => <StickerCategory>[
        logos,
        emoticons,
        shapes,
      ];

  Configuration _createConfiguration(bool forceCrop) {
    final configuration = Configuration(
      sticker: StickerOptions(
        personalStickers: true,
        categories: categories,
      ),
      forceCrop: forceCrop,
      transform: forceCrop
          ? TransformOptions(
              items: [CropRatio(512, 512)],
            )
          : null,
    );
    return configuration;
  }

  Future<String?> showImageEditor({required String filePath, bool forceCrop = false}) async {
    final result = await PESDK.openEditor(
      image: filePath,
      configuration: _createConfiguration(forceCrop),
    );
    return result?.image.replaceAll('file://', '');
  }
}
