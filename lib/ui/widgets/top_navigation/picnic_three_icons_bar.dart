import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';

class PicnicThreeIconsBar extends StatefulWidget {
  const PicnicThreeIconsBar({
    Key? key,
    required this.iconPath1,
    required this.iconPath2,
    required this.iconPath3,
    required this.title1,
    required this.title2,
    required this.title3,
    this.initialIndex = 0,
  }) : super(key: key);

  final String iconPath1;
  final String iconPath2;
  final String iconPath3;

  final String title1;
  final String title2;
  final String title3;

  final int initialIndex;

  @override
  State<PicnicThreeIconsBar> createState() => _PicnicThreeIconsBarState();
}

class _PicnicThreeIconsBarState extends State<PicnicThreeIconsBar> {
  late int index;
  @override
  void initState() {
    index = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PicnicTab(
          iconPath: widget.iconPath1,
          title: widget.title1,
          isActive: _amIActive(Tabs.first.index),
          onTap: () => _handleOnTap(Tabs.first.index),
        ),
        PicnicTab(
          iconPath: widget.iconPath2,
          title: widget.title2,
          isActive: _amIActive(Tabs.second.index),
          onTap: () => _handleOnTap(Tabs.second.index),
        ),
        PicnicTab(
          iconPath: widget.iconPath1,
          title: widget.title1,
          isActive: _amIActive(Tabs.third.index),
          onTap: () => _handleOnTap(Tabs.third.index),
        ),
      ],
    );
  }

  bool _amIActive(int myIndex) {
    return myIndex == index;
  }

  void _handleOnTap(int index) {
    setState(() {
      this.index = index;
    });
  }
}

enum Tabs { first, second, third }
