import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color? backgrounColor;
  final Color? iconColor;
  final double size;
  final double iconSize;
  const AppIcon(
      {Key? key,
      required this.icon,
      this.iconColor = const Color(0XFF756d54),
      this.backgrounColor = const Color(0XFFFCF4E4),
      this.size = 40,
      this.iconSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgrounColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
