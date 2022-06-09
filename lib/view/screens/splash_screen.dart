import 'package:emed/core/constants/color_const.dart';
import 'package:emed/view/auth/cubit/auth_cubit.dart';
import 'package:emed/view/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().calendarCntrl.selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    context.read<AuthCubit>().getUserCrefential().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/homeview");
      } else {
        Navigator.pushReplacementNamed(context, "/loginview");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.kMainBlue,
      body: _eMedBody(context),
    );
  }

  Container _eMedBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SizedBox(
          height: 150,
          child: SvgPicture.asset('assets/svg/iconlabel.svg'),
        ),
      ),
    );
  }
}
