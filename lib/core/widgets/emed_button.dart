import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/constants/font_const.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:flutter/material.dart';

class EMedBlueButton extends StatefulWidget {
  int index;
  int currentPage;
  String text;
  VoidCallback onpressed;

  EMedBlueButton({
    Key? key,
    required this.index,
    required this.text,
    required this.currentPage,
    required this.onpressed,
  }) : super(key: key);

  @override
  State<EMedBlueButton> createState() => _EMedBlueButtonState();
}

class _EMedBlueButtonState extends State<EMedBlueButton> {
  int temp = 0;
  Color? color;
  bool button = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: _eMedBlueButton(),
    );
  }

  ElevatedButton _eMedBlueButton() {
    return ElevatedButton(
      onPressed: widget.onpressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: Size(350, 55),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: color = ColorConst.kMainBlue),
      child: FittedBox(
        child: EmedText(
            text: widget.text,
            size: FontConst.kMediumFont,
            color: ColorConst.kWhite),
      ),
    );
  }
}
