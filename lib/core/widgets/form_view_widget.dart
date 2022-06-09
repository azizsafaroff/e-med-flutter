import 'package:emed/core/components/input_comp.dart';
import 'package:emed/core/constants/font_const.dart';
import 'package:emed/core/extentions/context_extension.dart';
import 'package:emed/core/widgets/emed_button.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:emed/view/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormFieldWidget extends StatelessWidget {
  FormFieldWidget({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.h * 0.03),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.h * 0.05, bottom: context.h * 0.01),
                      child: EmedText(
                        text: 'Phone number',
                        color: Colors.black,
                        size: FontConst.kMediumFont,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      // controller: context.watch<AuthCubit>().phonrController,
                      decoration: InputComp.inputDecoration(
                        hintText: "Your phone number...",
                      ),
                      validator: (number) {
                        if (number!.isEmpty) {
                          return "Enter your name";
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.h * 0.025, bottom: context.h * 0.01),
                      child: EmedText(
                        text: 'Password',
                        color: Colors.black,
                        size: FontConst.kMediumFont,
                      ),
                    ),
                    TextFormField(
                      // obscureText: context.watch<AuthCubit>().isHidden,
                      // controller: context.watch<AuthCubit>().passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputComp.inputDecoration(
                        hintText: "Your password...",
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //     context.watch<AuthCubit>().isHidden
                        //         ? Icons.visibility_off
                        //         : Icons.remove_red_eye,
                        //   ),
                        //   onPressed: () {
                            
                        //   },
                        // ),
                      ),
                      validator: (password) {
                        if (password!.isEmpty) {
                          return "Enter new password";
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.h * 0.34),
              EMedBlueButton(
                  index: 1,
                  text: 'Continue',
                  currentPage: 1,
                  onpressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/home');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  
}
