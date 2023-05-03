import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/ui/widgets/picnic_message_offer.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_message_offer',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 1,
      children: [
        GoldenTestScenario(
          name: 'sell',
          child: TestWidgetContainer(
            child: PicnicMessageOffer(
              avatarImage:
                  'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/picnic_logo.png?alt=media&token=',
              seedsCount: 200,
              price: 2.1,
              circleName: 'gacha',
              onTapPrimary: () {},
              onTapSecondary: () {},
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'buy',
          child: TestWidgetContainer(
            child: PicnicMessageOffer(
              avatarImage:
                  'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/picnic_logo.png?alt=media&token=',
              seedsCount: 200,
              price: 2.1,
              melonsCount: 7,
              circleName: 'gacha',
              onTapPrimary: () {},
              onTapSecondary: () {},
              messageOfferState: PicnicMessageOfferState.buy,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'buy-insufficient-money',
          child: TestWidgetContainer(
            child: PicnicMessageOffer(
              avatarImage:
                  'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/picnic_logo.png?alt=media&token=',
              seedsCount: 200,
              price: 2.1,
              melonsCount: 1.6,
              circleName: 'gacha',
              onTapSecondary: () {},
              messageOfferState: PicnicMessageOfferState.buy,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'buy-insufficient-money',
          child: const TestWidgetContainer(
            child: PicnicMessageOffer(
              avatarImage:
                  'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/picnic_logo.png?alt=media&token=',
              seedsCount: 200,
              price: 2.1,
              circleName: 'gacha',
              messageOfferState: PicnicMessageOfferState.rejected,
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'buy-insufficient-money',
          child: const TestWidgetContainer(
            child: PicnicMessageOffer(
              avatarImage:
                  'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/picnic_logo.png?alt=media&token=',
              seedsCount: 200,
              price: 2.1,
              circleName: 'gacha',
              messageOfferState: PicnicMessageOfferState.purchased,
            ),
          ),
        ),
      ],
    ),
  );
}
