import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/ui/widgets/picnic_background.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_presentation_model.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_presenter.dart';

class AppInitPage extends StatefulWidget with HasPresenter<AppInitPresenter> {
  const AppInitPage({
    super.key,
    required this.presenter,
  });

  @override
  final AppInitPresenter presenter;

  @override
  State<AppInitPage> createState() => _AppInitPageState();
}

class _AppInitPageState extends State<AppInitPage>
    with PresenterStateMixin<AppInitViewModel, AppInitPresenter, AppInitPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) => const PicnicBackground();
}
