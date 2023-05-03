// ignore_for_file: cancel_subscriptions

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

//ignore:prefer-match-file-name
mixin PresenterStateMixin<M, P extends Cubit<M>, T extends HasPresenter<P>> on State<T> {
  P get presenter => widget.presenter;

  M get state => presenter.state;

  bool disposePresenter = true;

  Widget stateObserver({
    required BlocWidgetBuilder<M> builder,
    BlocBuilderCondition<M>? buildWhen,
  }) {
    return BlocBuilder<P, M>(
      bloc: presenter,
      buildWhen: buildWhen,
      builder: builder,
    );
  }

  Widget stateListener({
    required BlocWidgetListener<M> listener,
    BlocListenerCondition<M>? listenWhen,
    Widget? child,
  }) {
    return BlocListener<P, M>(
      bloc: presenter,
      listener: listener,
      listenWhen: listenWhen,
      child: child,
    );
  }

  Widget stateConsumer({
    required BlocWidgetListener<M> listener,
    required BlocWidgetBuilder<M> builder,
    BlocListenerCondition<M>? listenWhen,
    BlocBuilderCondition<M>? buildWhen,
  }) {
    return BlocConsumer<P, M>(
      bloc: presenter,
      listener: listener,
      listenWhen: listenWhen,
      buildWhen: buildWhen,
      builder: builder,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (disposePresenter) {
      presenter.close();
    }
  }
}

mixin HasPresenter<P> on StatefulWidget {
  P get presenter;
}

mixin PresenterStateMixinAuto<M, P extends Cubit<M>, T extends HasInitialParams> on State<T> {
  late final P presenter = getIt(param1: widget.initialParams);

  M get state => presenter.state;

  bool disposePresenter = true;

  Widget stateObserver({
    required BlocWidgetBuilder<M> builder,
    BlocBuilderCondition<M>? buildWhen,
  }) {
    return BlocBuilder<P, M>(
      bloc: presenter,
      buildWhen: buildWhen,
      builder: builder,
    );
  }

  Widget stateListener({
    required BlocWidgetListener<M> listener,
    BlocListenerCondition<M>? listenWhen,
    Widget? child,
  }) {
    return BlocListener<P, M>(
      bloc: presenter,
      listener: listener,
      listenWhen: listenWhen,
      child: child,
    );
  }

  Widget stateConsumer({
    required BlocWidgetListener<M> listener,
    required BlocWidgetBuilder<M> builder,
    BlocListenerCondition<M>? listenWhen,
    BlocBuilderCondition<M>? buildWhen,
  }) {
    return BlocConsumer<P, M>(
      bloc: presenter,
      listener: listener,
      listenWhen: listenWhen,
      buildWhen: buildWhen,
      builder: builder,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (disposePresenter) {
      presenter.close();
    }
  }
}

mixin HasInitialParams on StatefulWidget {
  dynamic get initialParams;
}

mixin SubscriptionsMixin<T> on Cubit<T> {
  final _subscriptions = <String, StreamSubscription<dynamic>>{};

  /// To avoid start listening the same stream twice we have to provide unique [subscriptionId]
  void listenTo<C>({
    required Stream<C> stream,
    required String subscriptionId,
    required void Function(C) onChange,
  }) {
    if (!_subscriptions.containsKey(subscriptionId) && !isClosed) {
      final subscription = stream.listen(onChange);
      addSubscription(subscriptionId, subscription);
    }
  }

  void addSubscription(String id, StreamSubscription<dynamic> subscription) {
    _subscriptions[id]?.cancel();
    _subscriptions[id] = subscription;
  }

  ///Cancel and close single subscriptions
  Future<void> closeSubscription(String subscriptionId) async {
    final subscription = _subscriptions[subscriptionId];
    if (subscription != null) {
      await subscription.cancel();
      _subscriptions.remove(subscriptionId);
    }
  }

  ///Cancel and close all subscriptions
  @override
  Future<void> close() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
    await super.close();
    _subscriptions.clear();
  }
}
