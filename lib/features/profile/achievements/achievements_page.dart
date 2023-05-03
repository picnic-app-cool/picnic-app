// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presentation_model.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presenter.dart';

class AchievementsPage extends StatefulWidget with HasPresenter<AchievementsPresenter> {
  const AchievementsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final AchievementsPresenter presenter;

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage>
    with PresenterStateMixin<AchievementsViewModel, AchievementsPresenter, AchievementsPage> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text("AchievementsPage\n(NOT IMPLEMENTED YET)"),
        ),
      );
}
