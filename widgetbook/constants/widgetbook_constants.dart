import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetBookConstants {
  //create array in component
  static const LinearGradient picnicGradient = LinearGradient(
    colors: [
      Color(0XFFFFE380),
      Color(0XFFFF9D92),
      Color(0XFFED7DFF),
      Color(0XFFC575FF),
      Color(0XFF80ABFF),
      Color(0XFFA8FAFF),
    ],
  );

  static const LinearGradient picnicPostGradientBlue = LinearGradient(
    colors: [
      Color(0XFF86C8F5),
      Color(0XFF6AAAF5),
      Color(0XFF97A9F5),
    ],
  );

  static const LinearGradient picnicPostGradientPurple = LinearGradient(
    colors: [
      Color(0XFFBE86F5),
      Color(0XFFA76AF5),
      Color(0XFFA497F5),
    ],
  );

  static const LinearGradient picnicPostGradientGold = LinearGradient(
    colors: [
      Color(0XFFEDD766),
      Color(0XFFE3C26E),
      Color(0XFFE4C383),
    ],
  );

  static const LinearGradient picnicPostGradientGreen = LinearGradient(
    colors: [
      Color(0XFF93DF78),
      Color(0XFF61DA7C),
      Color(0XFFA4DA7B),
    ],
  );

  static const LinearGradient picnicPostGradientPink = LinearGradient(
    colors: [
      Color(0XFFFF91AB),
      Color(0XFFF4779D),
      Color(0XFFFE9FC1),
    ],
  );

  static const emojiList = [
    Option(
      label: "PC",
      value: '💻‍',
    ),
    Option(
      label: "Smile",
      value: '😃',
    ),
    Option(
      label: "Heart",
      value: '❤️',
    ),
    Option(
      label: "Woman",
      value: '🙎🏻‍',
    ),
    Option(
      label: "None",
      value: null,
    ),
    Option(
      label: "Portuguese",
      value: '🇧🇷',
    ),
    Option(
      label: "Spanish",
      value: '🇪🇸',
    ),
    Option(
      label: "English",
      value: '🏴󠁧󠁢󠁥󠁮󠁧󠁿󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "German",
      value: '󠁧󠁢󠁥󠁮󠁧🇩🇪󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Space Ship",
      value: '󠁧🚀󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Cake",
      value: '🎂󠁧󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Mobile",
      value: '📱󠁧󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Key",
      value: '🔑󠁧󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Flames",
      value: '🔥󠁧󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Man",
      value: '👲🏻󠁧󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Bell",
      value: '🔔󠁧󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Speech",
      value: '💬󠁧󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
    Option(
      label: "Confetti",
      value: '🎉󠁧󠁧󠁢󠁥󠁮󠁧󠁿',
    ),
  ];

  static List<Option<String>> topIconsList = [
    Option(label: 'bell', value: Assets.images.bell.path),
    Option(label: 'setting', value: Assets.images.setting.path),
    Option(label: 'save', value: Assets.images.save.path),
    Option(label: 'arrow left', value: Assets.images.arrowlefttwo.path),
    Option(label: 'bookmark', value: Assets.images.bookmark.path),
    Option(label: 'edit', value: Assets.images.edit.path),
  ];

  static final List<Option<String>> icons = [
    Option(label: 'chat', value: Assets.images.chat.path),
    Option(label: 'profile', value: Assets.images.profile.path),
    Option(label: 'users', value: Assets.images.tusers.path),
  ];

  static List<TextPostColor> get defaultColorSelectionOptions => TextPostColor.selectableValues;

  static List<Option<Color?>> colorOptionsNullable = [
    Option(label: "Default", value: PicnicColors().darkBlue.shade600),
    const Option(label: "Blue", value: Colors.blue),
    const Option(label: "Red", value: Colors.red),
    const Option(label: "Green", value: Colors.green),
    const Option(label: "Black", value: Colors.black),
    const Option(label: "None", value: null),
  ];
}
