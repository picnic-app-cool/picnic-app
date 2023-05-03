import 'package:picnic_app/ui/widgets/picnic_message_offer.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicMessageOfferUseCases extends WidgetbookComponent {
  PicnicMessageOfferUseCases()
      : super(
          name: '$PicnicMessageOffer',
          useCases: [
            WidgetbookUseCase(
              name: 'Message Offer Use Cases',
              builder: (context) {
                return PicnicMessageOffer(
                  onTapPrimary: () {},
                  onTapSecondary: () {},
                  circleName: context.knobs.text(
                    label: 'Message Offer Circle Name',
                    initialValue: 'circle',
                  ),
                  melonsCount: context.knobs.slider(
                    label: 'Melons Count',
                    initialValue: 0,
                    min: 0,
                  ),
                  price: context.knobs.slider(
                    label: 'Offer Price',
                    initialValue: 0,
                    min: 0,
                  ),
                  seedsCount: context.knobs.slider(
                    label: 'Seeds Count',
                    initialValue: 0,
                    min: 0,
                  ),
                  messageOfferState: context.knobs.options(
                    label: 'Message Offer State',
                    options: [
                      const Option(
                        label: 'Sell',
                        value: PicnicMessageOfferState.sell,
                      ),
                      const Option(
                        label: 'Buy',
                        value: PicnicMessageOfferState.buy,
                      ),
                      const Option(
                        label: 'Rejected',
                        value: PicnicMessageOfferState.rejected,
                      ),
                      const Option(
                        label: 'Purchased',
                        value: PicnicMessageOfferState.purchased,
                      ),
                    ],
                  ),
                  avatarImage:
                      'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/picnic_logo.png?alt=media&token=',
                );
              },
            ),
          ],
        );
}
