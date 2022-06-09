import 'package:emed/core/constants/font_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewsTextFormFieldWidget extends StatefulWidget {
  const NewsTextFormFieldWidget({Key? key}) : super(key: key);

  @override
  _NewsTextFormFieldWidgetState createState() =>
      _NewsTextFormFieldWidgetState();
}

class _NewsTextFormFieldWidgetState extends State<NewsTextFormFieldWidget> {
  bool _isSecured = true;
  bool _isOpen = false;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      height: 250,
      width: double.infinity,
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: _userNameController,
            decoration: const InputDecoration(
              hintText: 'Enter your full name...',
              labelText: 'Full name',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              hintText: 'Enter your phone number...',
              labelText: 'Phone number',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: _isSecured,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Create your new password...',
              labelText: 'Create password',
              hintStyle:  TextStyle(
                color: Colors.grey,
              ),
              
            ),
          ),
        ],
      )),
    );
  }
}
