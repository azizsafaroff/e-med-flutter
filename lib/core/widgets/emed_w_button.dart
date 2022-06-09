import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/constants/font_const.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:flutter/material.dart';

class EMedWhiteButton extends StatefulWidget {
  int index;
  int currentPage;
  String text;
  VoidCallback onpressed;

  EMedWhiteButton({
    Key? key,
    required this.index,
    required this.text,
    required this.currentPage,
    required this.onpressed,
  }) : super(key: key);

  @override
  State<EMedWhiteButton> createState() => _EMedWhiteButtonState();
}

class _EMedWhiteButtonState extends State<EMedWhiteButton> {
  int temp = 0;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: _eMedWhiteButton(),
    );
  }

  OutlinedButton _eMedWhiteButton() {
    return OutlinedButton(
      onPressed: widget.onpressed,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(350, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        primary: color = ColorConst.kWhite,
      ),
      child: FittedBox(
        child: EmedText(
            text: widget.text,
            size: FontConst.kMediumFont,
            color: ColorConst.kMainBlue),
      ),
    );
  }
}
