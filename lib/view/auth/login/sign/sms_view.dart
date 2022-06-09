import 'package:emed/core/base/base_view/base_view.dart';
import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/constants/font_const.dart';
import 'package:emed/core/extentions/context_extension.dart';
import 'package:emed/core/widgets/appbar.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/core/widgets/emed_button.dart';
import 'package:emed/view/auth/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SmsView extends StatefulWidget {
  const SmsView({Key? key}) : super(key: key);

  @override
  _SmsViewState createState() => _SmsViewState();
}

class _SmsViewState extends State<SmsView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModal: SmsView,
        onPageBuilder: (context, widget) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: EMedAppBar(
              title: 'Sign Up',
            ),
            body: Padding(
              padding: EdgeInsets.all(context.h * 0.03),
              child: Column(
                children: [
                  EmedText(
                    text:
                        'We sent a confirmation code to your number.\n Please, enter the code',
                    color: Colors.black54,
                    size: FontConst.kMediumFont,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.h * 0.06),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.h * 0.05, bottom: context.h * 0.01),
                          child: EmedText(
                            text: 'Confirmation code',
                            color: Colors.black,
                            size: FontConst.kMediumFont,
                          ),
                        ),
                        PinCodeTextField(
                          controller: _smsController,
                          pinBoxRadius: 8,
                          autofocus: true,
                          highlight: true,
                          highlightColor: ColorConst.kMainBlue,
                          defaultBorderColor: Colors.grey,
                          maxLength: 6,
                          onDone: (text) {
                            context
                                .read<AuthCubit>()
                                .verificationCode(text, context);
                          },
                          pinBoxWidth: 46.0,
                          pinBoxHeight: 46.0,
                          wrapAlignment: WrapAlignment.spaceBetween,
                          pinBoxDecoration:
                              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                          pinTextStyle: TextStyle(fontSize: 22.0),
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 300),
                          highlightAnimationBeginColor: Colors.black54,
                          highlightAnimationEndColor: Colors.white12,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  RoundedLoadingButton(
                    animateOnTap: true,
                    controller: context.read<AuthCubit>().smsBtnController,
                    color: ColorConst.kMainBlue,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().verificationCode(
                            _smsController.text.trim(), context);
                      }
                    },
                    width: MediaQuery.of(context).size.width * 1.0,
                    elevation: 0,
                    child: EmedText(
                      text: 'Continue',
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
