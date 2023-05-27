import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/media_picker/utils/media_source_type.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class MediaPickerPermissionDenied extends StatelessWidget {
  //ignore: long-method
  MediaPickerPermissionDenied({
    Key? key,
    required this.mediaSourceType,
    required this.onSettingsTap,
    required this.microphonePermissionGranted,
    required this.cameraPermissionGranted,
  }) : super(key: key) {
    switch (mediaSourceType) {
      case MediaSourceType.gallery:
        title = appLocalizations.noAccesstoGalleryTitle;
        subTitle = appLocalizations.noAccesstoGalleryMessage;
        emojis = ["🖼️"];
        break;
      case MediaSourceType.cameraVideo:
        if (!microphonePermissionGranted && !cameraPermissionGranted) {
          title = appLocalizations.noAccessToCameraAndMicrophoneTitle;
          subTitle = appLocalizations.noAccessToCameraAndMicrophoneMessage;
        } else if (microphonePermissionGranted && !cameraPermissionGranted) {
          title = appLocalizations.noAccessToCameraTitle;
          subTitle = appLocalizations.noAccessToCameraMessage;
        } else if (!microphonePermissionGranted && cameraPermissionGranted) {
          title = appLocalizations.noAccessToMicrophoneTitle;
          subTitle = appLocalizations.noAccessToMicrophoneMessage;
        }
        emojis = [
          if (!cameraPermissionGranted) "📷",
          if (!microphonePermissionGranted) "🎙",
        ];
        break;
      case MediaSourceType.cameraImage:
        title = appLocalizations.noAccessToCameraTitle;
        subTitle = appLocalizations.noAccessToCameraMessage;
        emojis = ["📷"];
        break;
      case MediaSourceType.file:
        title = appLocalizations.noAccesstoFileTitle;
        subTitle = appLocalizations.noAccesstoFileMessage;
        emojis = ["📁"];
        break;
    }
  }

  final MediaSourceType mediaSourceType;
  final VoidCallback onSettingsTap;
  final bool microphonePermissionGranted;
  final bool cameraPermissionGranted;

  late final String title;
  late final String subTitle;
  late final List<String> emojis;

  static const emojiSize = 68.0;
  static const emojiTextSize = 33.0;
  static const declinedIconPadding = 9.0;
  static const declinedIconSize = 20.0;
  static const spaceBetweenEmojis = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int index = 0; index < emojis.length; index++)
                Padding(
                  padding: EdgeInsets.only(left: index != 0 ? spaceBetweenEmojis : 0),
                  child: SizedBox.square(
                    dimension: MediaPickerPermissionDenied.emojiSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: blackAndWhite.shade300,
                            ),
                          ),
                        ),
                        Text(
                          emojis[index],
                          style: const TextStyle(fontSize: MediaPickerPermissionDenied.emojiTextSize),
                        ),
                        Positioned(
                          right: MediaPickerPermissionDenied.declinedIconPadding,
                          bottom: MediaPickerPermissionDenied.declinedIconPadding,
                          child: SizedBox.square(
                            dimension: MediaPickerPermissionDenied.declinedIconSize,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colors.red,
                              ),
                              child: Image.asset(
                                Assets.images.close.path,
                                color: blackAndWhite.shade100,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const Gap(8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.styles.subtitle20,
          ),
          const Gap(2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: theme.styles.caption10,
            ),
          ),
          const Gap(8),
          PicnicButton(
            title: appLocalizations.goToSettings,
            onTap: onSettingsTap,
          ),
        ],
      ),
    );
  }
}
