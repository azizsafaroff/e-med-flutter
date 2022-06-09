import 'package:emed/core/base/base_view/base_view.dart';
import 'package:emed/core/constants/font_const.dart';
import 'package:emed/core/extentions/context_extension.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/core/widgets/emed_button.dart';
import 'package:emed/core/widgets/emed_w_button.dart';
import 'package:flutter/material.dart';
import 'package:emed/core/constants/color_const.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModal: LoginView,
        onPageBuilder: (context, widget) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConst.kWhite,
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: context.h * 0.15,
                    child: SvgPicture.asset('assets/svg/iconlogin.svg'),
                  ),
                  const Spacer(),
                  EmedText(
                    text: 'Your medical data \nis always with you',
                    color: Colors.black,
                    size: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Nunc orci sed sed posuere volutpat varius egestas sit. Amet, suscipit eget dis fusce quam in aliquet pulvinar.',
                    style: TextStyle(
                      fontSize: FontConst.kMediumFont,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 3),
                  EMedBlueButton(
                      index: 1,
                      text: 'Get Started',
                      currentPage: 1,
                      onpressed: () {
                        Navigator.pushNamed(context, '/signupview');
                      }),
                  const SizedBox(height: 16.0),
                  EMedWhiteButton(
                      index: 1,
                      text: 'Log In',
                      currentPage: 1,
                      onpressed: () {
                        Navigator.pushNamed(context, '/signinview');
                      }),
                ],
              ),
            ),
          );
        });
  }
}
