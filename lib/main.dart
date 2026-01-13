import 'package:dec/Views/AuthScreens/LoginScreenView.dart';
import 'package:dec/Views/AuthScreens/OTPScreenView.dart';
import 'package:dec/Views/AuthScreens/PhoneVerificationScreenView.dart';
import 'package:dec/Views/AuthScreens/SignupScreenView.dart';
import 'package:dec/Views/HomeScreenView.dart';
import 'package:dec/Views/MainScreenView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LogInScreenView.routeName,
      routes: {
        LogInScreenView.routeName: (context) => const LogInScreenView(),
        MainScreenView.routeName: (context) => const MainScreenView(),
        SignupScreenView.routeName: (context) => const SignupScreenView(),
        PhoneVerificationScreenView.routeName: (context) =>
            const PhoneVerificationScreenView(),
        OTPScreenView.routeName: (context) => const OTPScreenView(),
      },
    );
  }
}
