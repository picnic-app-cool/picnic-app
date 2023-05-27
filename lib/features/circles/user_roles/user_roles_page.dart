import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/roles_list/widgets/role_item.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presentation_model.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class UserRolesPage extends StatefulWidget with HasPresenter<UserRolesPresenter> {
  const UserRolesPage({
    super.key,
    required this.presenter,
  });

  @override
  final UserRolesPresenter presenter;

  @override
  State<UserRolesPage> createState() => _UserRolesPageState();
}

class _UserRolesPageState extends State<UserRolesPage>
    with PresenterStateMixin<UserRolesViewModel, UserRolesPresenter, UserRolesPage> {
  static const _heightFactorSelect = 0.7;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return stateObserver(
      builder: (context, state) => FractionallySizedBox(
        heightFactor: _heightFactorSelect,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34.0),
            child: stateObserver(
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(16),
                  Text(
                    appLocalizations.selectedRoles,
                    style: styles.subtitle40,
                    textAlign: TextAlign.left,
                  ),
                  const Gap(16),
                  if (state.isSearchEnabled)
                    PicnicSoftSearchBar(
                      hintText: appLocalizations.search,
                    ),
                  const Gap(16),
                  Text(
                    appLocalizations.rolesTitle,
                    style: theme.styles.subtitle40,
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: PicnicPagingListView<CircleCustomRole>(
                      paginatedList: state.allRoles,
                      loadMore: presenter.getUserRoles,
                      loadingBuilder: (_) => const PicnicLoadingIndicator(),
                      itemBuilder: (context, role) {
                        final isSelected = state.assignedRoles.contains(role);

                        return RoleItem(
                          roleName: role.name,
                          roleEmoji: role.emoji,
                          titleStyle: theme.styles.subtitle20.copyWith(color: role.formattedColor.color),
                          trailing: isSelected
                              ? Image.asset(
                                  Assets.images.checkboxSquare.path,
                                )
                              : Image.asset(
                                  Assets.images.checkboxSquareEmpty.path,
                                ),
                          onTap: () => presenter.onTapRole(role),
                        );
                      },
                    ),
                  ),
                  const Gap(12),
                  const Divider(
                    height: 1,
                  ),
                  const Gap(12),
                  Center(
                    child: PicnicTextButton(
                      label: appLocalizations.closeAction,
                      onTap: presenter.onTapClose,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
