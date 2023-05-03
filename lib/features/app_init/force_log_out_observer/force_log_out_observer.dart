// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/app_init/force_log_out_observer/force_log_out_observer_presenter.dart';

class ForceLogOutObserver extends StatefulWidget with HasPresenter<ForceLogOutObserverPresenter> {
  const ForceLogOutObserver({
    required this.presenter,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  final ForceLogOutObserverPresenter presenter;

  final Widget child;

  @override
  State<ForceLogOutObserver> createState() => _ForceLogOutObserverState();
}

class _ForceLogOutObserverState extends State<ForceLogOutObserver> {
  ForceLogOutObserverPresenter get presenter => widget.presenter;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  void dispose() {
    presenter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
