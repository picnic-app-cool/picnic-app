import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_desktop_app/features/main/main_presentation_model.dart';
import 'package:picnic_desktop_app/features/main/main_presenter.dart';
import 'package:picnic_desktop_app/features/main/widgets/main_page_view.dart';

class MainPage extends StatefulWidget with HasPresenter<MainPresenter> {
  const MainPage({
    super.key,
    required this.presenter,
  });

  @override
  final MainPresenter presenter;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with PresenterStateMixin<MainViewModel, MainPresenter, MainPage> {
  @override
  Widget build(BuildContext context) {
    return stateObserver(
      buildWhen: (previous, current) => previous.tabs != current.tabs,
      builder: (context, state) => MainPageView(
        items: state.tabs,
        recentItems: state.recentTabs,
        selectedItem: state.selectedTab,
        profile: state.privateProfile,
      ),
    );
  }
}
