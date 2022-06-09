import 'package:emed/core/widgets/errorsnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FirebaseAuthHelper {
  FirebaseAuth auth = FirebaseAuth.instance;

  login(String phonenumber, String password) async {}
  Future signup(
      BuildContext context,
      String phonenumber,
      RoundedLoadingButtonController btnController,
      void Function(String, int?) codeSent) async {
    btnController.start();

    await auth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (AuthCredential authCredential) {
        btnController.success();

        Future.delayed(const Duration(seconds: 2), () {
          btnController.stop();
        });

        auth
            .signInWithCredential(authCredential)
            .then((UserCredential result) {})
            .catchError((e) {
          print(e);
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException.message);
        btnController.stop();

        showErrorSnackBar(context, "Ups, Registration failed!");
      },
      codeSent: codeSent,
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        btnController.stop();
      },
    );
  }
}
