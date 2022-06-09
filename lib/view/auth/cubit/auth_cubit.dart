import 'package:emed/core/models/user.dart';
import 'package:emed/core/widgets/errorsnackbar.dart';
import 'package:emed/view/auth/firebase/helper.dart';
import 'package:emed/view/auth/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController get btnController => _btnController;

  final RoundedLoadingButtonController _smsBtnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController get smsBtnController => _smsBtnController;

  String? _verificationId;
  String? get verificationId => _verificationId;

  User? _user;
  User? get user => _user;

  UserData? _userInfo;
  UserData? get userInfo => _userInfo;

  Future<bool> getUserCrefential() async {
    _user = _auth.currentUser;
    if (_user != null) {
      CollectionReference users = _firestore.collection('users');

      String phoneNumber =
          "${_user!.phoneNumber!.substring(0, 4)} (${_user!.phoneNumber!.substring(4, 6)}) ${_user!.phoneNumber!.substring(6, 9)}-${_user!.phoneNumber!.substring(9, 11)}-${_user!.phoneNumber!.substring(11, 13)}";

      var result =
          await users.where("phonenumber", isEqualTo: phoneNumber).get();

      dynamic data = result.docs[0].data();

      _userInfo = UserData(
        data['name'],
        data['phonenumber'],
        data['password'],
        id: data['id'],
      );

      return true;
    } else {
      return false;
    }
  }

  Future addUser(
    String uid,
  ) async {
    CollectionReference users = _firestore.collection('users');

    var result = await users
        .where("phonenumber", isEqualTo: _userInfo!.phonenumber)
        .where("password", isEqualTo: _userInfo!.password)
        .get();

    if (result.docs.isNotEmpty) {
      return;
    } else {
      _userInfo!.id = uid;

      return await users
          .add({
            'id': _userInfo!.id,
            'name': _userInfo!.name,
            'phonenumber': _userInfo!.phonenumber,
            'password': _userInfo!.password
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  Future signup(
      String phonenumber, String name, String password, context) async {
    CollectionReference users = _firestore.collection('users');
    var result = await users.where("phonenumber", isEqualTo: phonenumber).get();

    if (result.docs.isNotEmpty) {
      _btnController.reset();

      showErrorSnackBar(context, "This user is available!");
      return;
    }

    _userInfo = UserData(name, phonenumber, password);

    await FirebaseAuthHelper().signup(context, phonenumber, _btnController,
        (String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
      Navigator.pushNamed(context, '/smsview');
      print(
          "Code sent your mobile phone: $phonenumber, verification id: $verificationId!");
    });
  }

  Future login(context, String phonenumber, String password) async {
    CollectionReference users = _firestore.collection('users');

    var result = await users
        .where("phonenumber", isEqualTo: phonenumber)
        .where("password", isEqualTo: password)
        .get();

    if (result.docs.isNotEmpty) {
      dynamic data = result.docs[0].data();

      _userInfo = UserData(
        data['name'],
        data['phonenumber'],
        data['password'],
        id: data['id'],
      );

      await FirebaseAuthHelper().signup(context, phonenumber, _btnController,
          (String verificationId, int? forceResendingToken) {
        _verificationId = verificationId;
        Navigator.pushNamed(context, '/smsview');
        print(
            "Code sent your mobile phone: $phonenumber, verification id: $verificationId!");
      });
    } else {
      _btnController.reset();

      showErrorSnackBar(context, "Ups, phone number or password is invalid!");
    }
  }

  Future verificationCode(String code, context) async {
    smsBtnController.start();

    if (_verificationId != null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: code);

      await _auth
          .signInWithCredential(credential)
          .then((UserCredential result) async {
        _user = result.user;

        await addUser(result.user!.uid);

        smsBtnController.success();

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/homeview', (route) => true);
        });

        _btnController.stop();
        smsBtnController.stop();

        _verificationId = null;
      }).catchError((e) {
        smsBtnController.reset();

        // showErrorSnackBar(context, "Ups, SMS code is invalid!");
      });
    } else {
      print("verification id is null: $_verificationId");
      smsBtnController.stop();
    }
  }

  signout(context) async {
    await _auth.signOut();
    _user = FirebaseAuth.instance.currentUser;
    _userInfo = null;

    Navigator.pushNamedAndRemoveUntil(context, "/loginview", (route) => false);
  }
}
