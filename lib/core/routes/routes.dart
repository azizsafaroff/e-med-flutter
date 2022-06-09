import 'package:emed/view/auth/login/sign/signin_view.dart';
import 'package:emed/view/auth/login/sign/signup_view.dart';
import 'package:emed/view/auth/login/sign/sms_view.dart';
import 'package:emed/view/doctor/view/confirm_doctor_view.dart';
import 'package:emed/view/doctor/view/info_doctor_view.dart';
import 'package:emed/view/hospital/view/info_hospital_view.dart';
import 'package:emed/view/treatment/view/info_drug_view.dart';
import 'package:emed/view/treatment/view/info_treatment_view.dart';
import 'package:flutter/material.dart';
import 'package:emed/view/auth/login/login_view.dart';
import 'package:emed/view/home/view/home_view.dart';
import 'package:emed/view/screens/splash_screen.dart';

class Routes {
  static final Routes _instance = Routes.init();
  static Routes get instantce => _instance;
  Routes.init();
  Route? onGeneralRoute(RouteSettings set) {
    var args = set.arguments;
    switch (set.name) {
      case '/splashscreen':
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case '/loginview':
        return MaterialPageRoute(builder: (context) => const LoginView());
      case '/signupview':
        return MaterialPageRoute(builder: (context) => const SignUpView());
      case '/smsview':
        return MaterialPageRoute(builder: (context) => const SmsView());  
      case '/signinview':
        return MaterialPageRoute(builder: (context) => const SignInView());
      case '/homeview':
        return MaterialPageRoute(builder: (context) =>  EmedHomeView());
      case '/infoDoctor':
        return MaterialPageRoute(builder: (context) =>  EmedInfoDoctorView(
          doctor: args,
        ));
      case '/confirmDoctor':
        return MaterialPageRoute(builder: (context) =>   EmedConfirmDoctorView(
          doctor: args,
        ));
      case '/infoHospital':
        return MaterialPageRoute(builder: (context) =>  EmedInfoHospitalView(
          hospital: args,
        ));
      case '/infoTreatment':
        return MaterialPageRoute(builder: (context) =>  EmedInfoTreatmentView(
          treatment: args,
        ));
      case '/infoDrug':
        return MaterialPageRoute(builder: (context) =>  EmedInfoDrugWidget(
          drug: args,
        ));
    }
  }
}

