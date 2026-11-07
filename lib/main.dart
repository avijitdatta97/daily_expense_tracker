import 'package:dec/Views/AuthScreens/LoginScreenView.dart';
import 'package:dec/Views/AuthScreens/OTPScreenView.dart';
import 'package:dec/Views/AuthScreens/PhoneVerificationScreenView.dart';
import 'package:dec/Views/AuthScreens/SignupScreenView.dart';
import 'package:dec/Views/MainScreenView.dart';
import 'package:dec/core/network/api_client.dart';
import 'package:dec/core/services/storage_service.dart';
import 'package:dec/data/repositories/auth_repository.dart';
import 'package:dec/data/repositories/category_repository.dart';
import 'package:dec/providers/auth_provider.dart';
import 'package:dec/providers/category_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
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
    return MultiProvider(
      providers: [
        // 1. Storage Service
        Provider<StorageService>(
          create: (_) => StorageService(),
        ),
        // 2. Api Client (depends on StorageService)
        ProxyProvider<StorageService, ApiClient>(
          update: (_, storageService, __) => ApiClient(storageService),
        ),
        // 3. Auth Repository (depends on ApiClient)
        ProxyProvider<ApiClient, AuthRepository>(
          update: (_, apiClient, __) => AuthRepository(apiClient),
        ),
        // 4. Category Repository (depends on ApiClient)
        ProxyProvider<ApiClient, CategoryRepository>(
          update: (_, apiClient, __) => CategoryRepository(apiClient),
        ),
        // 5. Auth Provider (depends on AuthRepository and StorageService)
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            context.read<AuthRepository>(),
            context.read<StorageService>(),
          ),
        ),
        // 6. Category Provider (depends on CategoryRepository)
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(
            context.read<CategoryRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
