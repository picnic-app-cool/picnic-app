import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_bottom_navigation.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_nav_item.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicBottomNavigationUseCase extends WidgetbookComponent {
  PicnicBottomNavigationUseCase()
      : super(
          name: "$PicnicBottomNavigation",
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Bottom Navigation Use Case",
              builder: (context) => PicnicBottomNavigation(
                activeItem: context.knobs.options(
                  label: 'Active item',
                  options: const [
                    Option(
                      label: 'Feed',
                      value: PicnicNavItem.feed,
                    ),
                    Option(
                      label: 'Chat',
                      value: PicnicNavItem.chat,
                    ),
                  ],
                ),
                showDecoration: context.knobs.boolean(label: 'Decoration?'),
                overlayTheme:
                    context.knobs.boolean(label: 'Dark color?') ? PostOverlayTheme.light : PostOverlayTheme.dark,
                onTap: (_) {},
                items: PicnicNavItem.values,
                onTabSwiped: (_) {},
              ),
            ),
          ],
        );
}
