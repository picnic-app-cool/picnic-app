import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presentation_model.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presenter.dart';
import 'package:picnic_app/features/circles/roles_list/widgets/role_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class RolesListPage extends StatefulWidget with HasPresenter<RolesListPresenter> {
  const RolesListPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final RolesListPresenter presenter;

  @override
  State<RolesListPage> createState() => _RolesListPageState();
}

class _RolesListPageState extends State<RolesListPage>
    with PresenterStateMixin<RolesListViewModel, RolesListPresenter, RolesListPage> {
  static const _padding = EdgeInsets.symmetric(horizontal: 24.0);
  static const _iconWidth = 18.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: theme.colors.blackAndWhite.shade100,
        titleText: appLocalizations.rolesTitle,
      ),
      body: stateObserver(
        builder: (context, state) {
          return Padding(
            padding: _padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appLocalizations.rolesTitle, style: styles.title30),
                    if (state.hasPermissionToManageRoles)
                      PicnicTextButton(
                        label: appLocalizations.addAction,
                        onTap: presenter.onTapAddRole,
                        labelStyle: theme.styles.title20.copyWith(color: colors.green),
                      ),
                  ],
                ),
                Expanded(
                  child: PicnicPagingListView<CircleCustomRole>(
                    paginatedList: state.roles,
                    loadMore: presenter.loadMoreRoles,
                    loadingBuilder: (_) => const PicnicLoadingIndicator(),
                    itemBuilder: (context, role) {
                      final _trailingActions = Row(
                        children: [
                          if (role.meta.deletable)
                            GestureDetector(
                              onTap: () => presenter.onTapDeleteRole(role),
                              child: Assets.images.deleteSolid.image(color: colors.pink.shade500, width: _iconWidth),
                            ),
                          const Gap(12),
                          if (role.meta.configurable)
                            GestureDetector(
                              onTap: () => presenter.onTapEditRole(role),
                              child: Assets.images.settingSolid
                                  .image(color: colors.blackAndWhite.shade900, width: _iconWidth),
                            ),
                        ],
                      );
                      return RoleItem(
                        roleName: role.name,
                        roleEmoji: role.emoji,
                        titleStyle: theme.styles.title10.copyWith(color: role.formattedColor.color),
                        trailing: state.hasPermissionToManageRoles ? _trailingActions : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
