import 'package:picnic_app/core/utils/durations.dart';

class Constants {
  static const heartEmoji = '❤️';
  static const cogWheelEmoji = '⚙️';
  static const laptopEmoji = '💻';
  static const smileEmoji = '😃';
  static const sadEmoji = '☹️';
  static const speechEmoji = '💬';
  static const noEntryEmoji = '⛔️';
  static const bustsInSilhouetteEmoji = '👥';
  static const scrollEmoji = '📜';
  static const noCrownEmoji = '👑';
  static const faceTongueEmoji = '😜';
  static const lockEmoji = '🔒';
  static const partyPopperEmoji = '🎉';

  static const statsFollowers = '152K';
  static const hugEmoji = '🤗';
  static const viewsStats = '44K';

  static const brazilianFlag = '🇧🇷';
  static const philippinesFlag = '🇵🇭';
  static const indianFlag = '🇮🇳';
  static const americanFlag = '🇺🇸';
  static const germanFlag = '🇩🇪';
  static const spanishFlag = '🇪🇸';
  static const englishFlag = '🏴󠁧󠁢󠁥󠁮󠁧󠁿󠁧󠁢󠁥󠁮󠁧󠁿';

  static const eyesEmoji = '👀';
  static const spaceShip = '󠁧🚀󠁧󠁢';
  static const emojiWaterMelon = '🍉';
  static const emojiSeeNoEvilMonkey = '🙈';
  static const emojiClipboard = '📋';
  static const count = '21';

  static const downArrowWidthAppBar = 12.0;
  static const emojiSize = 18.0;
  static const mediumEmojiSize = 24.0;
  static const lowOpacityValue = 0.4;
  static const opacityWhiteValue = 0.7;
  static const fullOpacityValue = 1.0;

  static const smallPadding = 8.0;
  static const lowPadding = 12.0;
  static const defaultPadding = 16.0;
  static const mediumPadding = 20.0;
  static const largePadding = 24.0;

  static const borderWidthM = 2.0; // TODO move it to theme
  static const borderRadiusM = 8.0; // TODO move it to theme
  static const borderRadiusML = 12.0; // TODO move it to theme
  static const borderRadiusL = 16.0; // TODO move it to theme

  static const splashTransitionDuration = Duration(seconds: 1);

  static const double toolbarHeight = 64.0; // TODO move it to theme

  /// Specifies amount of pixels for the gap between the top of the feed page and post content.
  /// This gap is reserved for feed's appbar.
  static const postInFeedNavBarGapHeight = 22.0;

  static const onboardingTransitionDuration = MediumDuration();
  static const onboardingImageBgOpacity = 0.05;
  static const onboardingEmojiSize = 35.0;
  static const onboardingEmojiLargeSize = 45.0;

  static const slidingTransitionDuration = MediumDuration();

  static const listEmojiSize = 20.0;

  static const dateFormat24hours = "HH:mm";
  static const dateFormatSingleDay = "MM/dd/yyyy ";

  static const defaultCommentsDepthLevel = 5;

  static const maxVideoPostDuration = Duration(seconds: 30);

  static const defaultCommentsPreviewCount = 6;

  /// determines how much percent of given post needs to be visible on the screen to have the post be considered
  /// as currently visible. this determines the overlay color in feed (which bases on currently wvisible post) as well
  /// as when the post should play
  static const postVisibilityThreshold = 0.5;

  static const imglyLicenseAndroidExtension = '.android';
  static const imglyLicenseIosExtension = '.ios';

  static const videoPostCommentsCount = 3;

  static const imagePostCommentsCount = 3;

  static const commentInBottomSheetMaxLines = 3;

  static const forYouFeedIndex = 0;

  static const iOSUrl = 'https://apps.apple.com/app/id';
  static const androidUrl = 'https://play.google.com/store/apps/details?id=';

  static const termsUrl = 'https://www.notion.so/picnic-app/Terms-Conditions-34c0ed24030144d7b75d2a41fafee75c';
  static const policiesUrl =
      'https://picnic-app.notion.site/picnic-app/Privacy-Policy-a1428111659f4469a43d75a0bb520e6e';

  //don't use values below 20 seconds, otherwise backend will fail
  static const shortLivedTokenTTLSeconds = 20;
}
