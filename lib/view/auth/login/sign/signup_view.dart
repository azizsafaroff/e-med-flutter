import 'package:emed/core/base/base_view/base_view.dart';
import 'package:emed/core/components/input_comp.dart';
import 'package:emed/core/constants/color_const.dart';
import 'package:emed/core/constants/font_const.dart';
import 'package:emed/core/extentions/context_extension.dart';
import 'package:emed/core/widgets/appbar.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/view/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController(text: '+998 ');
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModal: SignUpView,
        onPageBuilder: (context, widget) {
          return Scaffold(
            appBar: EMedAppBar(title: 'Sign Up'),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(context.h * 0.03),
                child: Column(
                  children: [
                    EmedText(
                      text:
                          'Sign up in order to get a full access to the \nsystem',
                      color: Colors.black54,
                      size: FontConst.kMediumFont,
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: context.h * 0.05,
                                bottom: context.h * 0.01),
                            child: EmedText(
                              text: 'Full name',
                              color: Colors.black,
                              size: FontConst.kMediumFont,
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputComp.inputDecoration(
                              hintText: "Enter your full name...",
                            ),
                            validator: (text) {
                              if (text!.length < 3) {
                                return "Please, enter your full name!";
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: context.h * 0.05,
                                bottom: context.h * 0.01),
                            child: EmedText(
                              text: 'Phone number',
                              color: Colors.black,
                              size: FontConst.kMediumFont,
                            ),
                          ),
                          TextFormField(
                            controller: _phoneController,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                  mask: '+998 (##) ###-##-##',
                                  filter: {"#": RegExp(r'[0-9]')},
                                  type: MaskAutoCompletionType.lazy)
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputComp.inputDecoration(),
                            validator: (text) {
                              if (text!.length != 19) {
                                return "Number  must be +998(XX) XXX-XX-XX !";
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: context.h * 0.01,
                                bottom: context.h * 0.04),
                            child: EmedText(
                              text:
                                  'We will send confirmation code to this number',
                              color: Colors.black54,
                              size: FontConst.kSmallFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: context.h * 0.01,
                                bottom: context.h * 0.01),
                            child: EmedText(
                              text: 'Create password',
                              color: Colors.black,
                              size: FontConst.kMediumFont,
                            ),
                          ),
                          TextFormField(
                            obscureText: !isHidden,
                            controller: _passwordController,
                            decoration: InputComp.inputDecoration(
                              hintText: "Create your new password...",
                              suffixIcon: IconButton(
                                splashRadius: 20.0,
                                icon: Icon(isHidden
                                    ? Icons.remove_red_eye_rounded
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  isHidden = !isHidden;
                                  setState(() {});
                                },
                              ),
                            ),
                            validator: (text) {
                              if (text!.length < 6) {
                                return "Password length must be greater than 6 characters!";
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: context.h * 0.05,
                                bottom: context.h * 0.01),
                            child: EmedText(
                              text: 'Confirm password',
                              color: Colors.black,
                              size: FontConst.kMediumFont,
                            ),
                          ),
                          TextFormField(
                            obscureText: !isHidden,
                            controller: _confirmController,
                            decoration: InputComp.inputDecoration(
                              hintText: "Confirm your new password...",
                              suffixIcon: IconButton(
                                splashRadius: 20.0,
                                icon: Icon(isHidden
                                    ? Icons.remove_red_eye_rounded
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  isHidden = !isHidden;
                                  setState(() {});
                                },
                              ),
                            ),
                            validator: (text) {
                              if (_passwordController.text !=
                                  _confirmController.text) {
                                return "Password entered incorrectly!";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.h * 0.12),
                    RoundedLoadingButton(
                      animateOnTap: true,
                      controller: context.read<AuthCubit>().btnController,
                      color: ColorConst.kMainBlue,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signup(
                              _phoneController.text.trim(),
                              _nameController.text.trim(),
                              _passwordController.text.trim(),
                              context);
                        } else {
                          context.read<AuthCubit>().btnController.reset();
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
            ),
          );
        });
  }
}
