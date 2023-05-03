// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presentation_model.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presenter.dart';
import 'package:picnic_app/features/settings/get_verified/widgets/get_verified_list.dart';
import 'package:picnic_app/features/settings/get_verified/widgets/verified_avatar.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_background.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class GetVerifiedPage extends StatefulWidget with HasPresenter<GetVerifiedPresenter> {
  const GetVerifiedPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final GetVerifiedPresenter presenter;

  @override
  State<GetVerifiedPage> createState() => _GetVerifiedPageState();
}

class _GetVerifiedPageState extends State<GetVerifiedPage>
    with PresenterStateMixin<GetVerifiedViewModel, GetVerifiedPresenter, GetVerifiedPage> {
  static const _avatarSize = 110.0;
  static const _defaultRadius = 40.0;
  static const _contentTopPadding = 200.0;
  static const _sidePadding = 24.0;
  static const _contentInsidePadding = EdgeInsets.symmetric(horizontal: 24.0);
  static const _borderRadius = BorderRadius.only(
    topLeft: Radius.circular(_defaultRadius),
    topRight: Radius.circular(_defaultRadius),
  );

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    const avatarPadding = EdgeInsets.only(
      top: _contentTopPadding - _avatarSize / 2,
      right: _sidePadding,
    );

    return Material(
      child: Stack(
        children: [
          const PicnicBackground(),
          const PicnicAppBar(),
          Padding(
            padding: const EdgeInsets.only(top: _contentTopPadding),
            child: Container(
              padding: _contentInsidePadding,
              decoration: BoxDecoration(
                color: blackAndWhite.shade100,
                borderRadius: _borderRadius,
                border: Border.all(color: blackAndWhite.shade300),
              ),
              child: stateObserver(
                builder: (context, state) => GetVerifiedList(
                  onTapCommunityGuidelines: presenter.onTapCommunityGuidelines,
                  onTapApply: presenter.onTapApply,
                  applyUrl: state.applyLink,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: avatarPadding,
              child: VerifiedAvatar(
                avatarSize: _avatarSize,
                imagePath: Assets.images.picnicLogo.path,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
