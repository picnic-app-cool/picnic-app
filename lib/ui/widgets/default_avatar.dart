import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';

/// Widget for default avatar which is random for given emoji list.
/// For the user you can use factory constructor and optionally pass the [hash].
/// The [hash] is responsible for giving the same emoji from predefined list for the same [hash] value.
class DefaultAvatar extends StatelessWidget {
  const DefaultAvatar({
    Key? key,
    this.avatarSize = _size,
    required this.emoji,
  }) : super(key: key);

  factory DefaultAvatar.user({
    int? hash,
    double avatarSize = _size,
  }) {
    final length = _defaultEmojis.length;
    final index = (hash ?? Random().nextInt(length)) % length;
    return DefaultAvatar(
      avatarSize: avatarSize,
      emoji: _defaultEmojis[index],
    );
  }

  factory DefaultAvatar.seed({
    double avatarSize = _size,
  }) =>
      DefaultAvatar(
        avatarSize: avatarSize,
        emoji: _defaultSeedEmoji,
      );

  factory DefaultAvatar.circle({
    double avatarSize = _size,
    int? hash,
  }) {
    final length = _defaultEmojis.length;
    final index = (hash ?? Random().nextInt(length)) % length;
    return DefaultAvatar(
      avatarSize: avatarSize,
      emoji: _defaultEmojis[index],
    );
  }

  final double avatarSize;
  final String emoji;

  static const _size = 40.0;
  static const _sizeDivider = 2.0;
  static const _defaultEmojis = [
    '😃',
    '😄',
    '☺️',
    '😊',
    '🙂',
    '🙃',
  ];

  static const _defaultSeedEmoji = Constants.smileEmoji;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: avatarSize / _sizeDivider),
        ),
      ),
    );
  }
}
