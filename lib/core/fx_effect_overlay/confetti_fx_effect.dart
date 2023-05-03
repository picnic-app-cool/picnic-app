import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/fx_effect_overlay/fx_effect.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/widgets/animated_endless_rotation.dart';

const _avatarSize = 50.0;

class ConfettiFxEffect extends FxEffect {
  ConfettiFxEffect({
    required super.duration,
    required this.pieceBuilder,
    this.updateDuration = const Duration(milliseconds: 16),
  });

  factory ConfettiFxEffect.avatar(ImageUrl avatarUrl) => ConfettiFxEffect(
        duration: const Duration(seconds: 4),
        pieceBuilder: (context) => PicnicAvatar(
          boxFit: PicnicAvatarChildBoxFit.cover,
          imageSource: PicnicImageSource.url(
            fit: BoxFit.cover,
            avatarUrl,
            width: _avatarSize,
            height: _avatarSize,
          ),
          placeholder: () => DefaultAvatar.user(
            avatarSize: _avatarSize,
          ),
        ),
      );

  final Duration updateDuration;
  final WidgetBuilder pieceBuilder;
  final _random = Random();

  static const _minPieceCount = 10;
  static const _maxAdditionalPieceCount = 20;
  static const _minScale = 0.5;

  @override
  Widget build(BuildContext context) => _FallingItemsWidget(
        updateDuration: updateDuration,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        pieceWidgets: List.generate(
          _minPieceCount + (_random.nextDouble() * _maxAdditionalPieceCount).toInt(),
          (index) => Transform.scale(
            scale: _minScale + _random.nextDouble() * _minScale,
            child: AnimatedEndlessRotation(
              child: pieceBuilder(context),
            ),
          ),
        ),
      );
}

class _GravityItem {
  _GravityItem({
    required this.gravity,
    required Offset startPosition,
    required this.child,
  }) : _position = startPosition;

  final Offset gravity;
  final Widget child;

  Offset _position;

  Offset get position => _position;

  void update() {
    _position = _position + gravity;
  }
}

class _FallingItemsWidget extends StatefulWidget {
  const _FallingItemsWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.updateDuration,
    required this.pieceWidgets,
  }) : super(key: key);

  final List<Widget> pieceWidgets;
  final double width;
  final double height;
  final Duration updateDuration;

  @override
  State<_FallingItemsWidget> createState() => _FallingItemsWidgetState();
}

class _FallingItemsWidgetState extends State<_FallingItemsWidget> {
  late List<_GravityItem> _items;
  Timer? _updateTimer;

  static const _minGravity = 5.0;
  static const _maxAdditionalGravity = 10.0;
  static const _yOffset = 300;

  final _random = Random();

  double get _randomDouble => _random.nextDouble();

  @override
  void initState() {
    _items = widget.pieceWidgets
        .map(
          (e) => _GravityItem(
            gravity: Offset(
              0,
              _minGravity + _randomDouble * _maxAdditionalGravity,
            ),
            startPosition: Offset(
              _randomDouble * widget.width,
              -_yOffset + _randomDouble * _yOffset,
            ),
            child: e,
          ),
        )
        .toList();
    super.initState();

    _updateTimer = Timer.periodic(
      widget.updateDuration,
      (_) => _update(),
    );
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: _items
              .map(
                (e) => Positioned(
                  top: e.position.dy,
                  left: e.position.dx,
                  child: e.child,
                ),
              )
              .toList(),
        ),
      );

  void _update() {
    setState(() {
      for (final piece in _items) {
        piece.update();
      }
    });
  }
}
