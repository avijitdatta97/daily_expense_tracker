import 'package:dec/Views/AuthScreens/LoginScreenView.dart';
import 'package:dec/Views/AuthScreens/OTPScreenView.dart';
import 'package:dec/Views/AuthScreens/PhoneVerificationScreenView.dart';
import 'package:dec/Views/AuthScreens/SignupScreenView.dart';
import 'package:dec/Views/HomeScreenView.dart';
import 'package:dec/Views/MainScreenView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LogInScreenView.routeName,
      theme: ThemeData(
        useMaterial3: true,
      ),
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
