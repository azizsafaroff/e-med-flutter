// import 'dart:ui';
import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:flutter/material.dart';

class EMedAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Color? color;
  Color? textColor = ColorConst.kMainBlue;

  EMedAppBar({Key? key, required this.title, this.textColor, this.color})
      : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 4.0),
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.0,
              color: ColorConst.kMainBlue,
            ),
            const SizedBox(width: 4.0),
            EmedText(
              text: "Back",
              size: 16.0,
              color: ColorConst.kMainBlue,
            ),
          ],
        ),
      ),
      leadingWidth: 70.0,
      centerTitle: true,
      backgroundColor: ColorConst.kWhite,
      elevation: 0.5,
      foregroundColor: ColorConst.kMainBlue,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'HKGrotesk',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
