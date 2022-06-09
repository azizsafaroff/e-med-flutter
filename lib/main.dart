import 'dart:io';

import 'package:emed/core/components/Theme/theme_comp.dart';
import 'package:emed/core/routes/routes.dart';
import 'package:emed/view/auth/cubit/auth_cubit.dart';
import 'package:emed/view/home/cubit/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(),
        ),
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-med',
        theme: ThemeComp.materialTheme,
        onGenerateRoute: Routes.instantce.onGeneralRoute,
        initialRoute: '/splashscreen',
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
