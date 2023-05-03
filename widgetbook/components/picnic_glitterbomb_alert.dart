import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/ui/widgets/picnic_glitterbomb_alert.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicGlitterbombAlertUseCases extends WidgetbookComponent {
  PicnicGlitterbombAlertUseCases()
      : super(
          name: "$PicnicGlitterBombAlert",
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Glitterbomb Alert Use Cases",
              builder: (context) => PicnicGlitterBombAlert(
                avatarImage: ImageUrl(
                  context.knobs.text(
                    label: 'Avatar',
                    initialValue: '😍',
                  ),
                ),
                onTapGlitterbombBack: () => {},
                senderUsername: context.knobs.text(
                  label: 'Sender username',
                  initialValue: 'username',
                ),
              ),
            ),
          ],
        );
}
