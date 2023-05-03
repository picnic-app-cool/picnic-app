import 'package:widgetbook/widgetbook.dart';

import '../components/posts/picnic_vertical_post.dart';

class PostsFolder extends WidgetbookFolder {
  PostsFolder()
      : super(
          name: "Posts",
          widgets: [
            PicnicVerticalPostComponent(),
          ],
        );
}
