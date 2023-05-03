import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicPollPostUseCases extends WidgetbookComponent {
  PicnicPollPostUseCases()
      : super(
          name: "$PicnicPollPost",
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Poll Post Use Cases",
              builder: (context) {
                return PicnicPollPost(
                  onVote: (vote) {},
                  userImageUrl: ImageUrl(
                    context.knobs.text(
                      label: 'User Image URL',
                      initialValue:
                          'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/picnic_logo.png?alt=media&token=',
                    ),
                  ),
                  leftImage: ImageUrl(
                    context.knobs.text(
                      label: 'Left Poll Image URL',
                      initialValue:
                          'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/mock-images%2Fpost_drink.webp?alt=media&token=',
                    ),
                  ),
                  leftVotes: context.knobs.slider(
                    label: 'Left Votes',
                    min: 0,
                    max: 1.0,
                    initialValue: 0.5,
                  ),
                  rightImage: ImageUrl(
                    context.knobs.text(
                      label: 'Right Poll Image URL',
                      initialValue:
                          'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/mock-images%2Fpost_drink.webp?alt=media&token=',
                    ),
                  ),
                  rightVotes: context.knobs.slider(
                    label: 'Right Votes',
                    min: 0,
                    max: 1.0,
                    initialValue: 0.2,
                  ),
                );
              },
            ),
          ],
        );
}
