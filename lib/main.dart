import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/routes/app_routes.dart';
import 'package:first_app_flutter/services/item_service.dart';
import 'package:first_app_flutter/services/transaction_service.dart';
import 'package:first_app_flutter/views/home/home_screen.dart';
import 'package:first_app_flutter/views/login/login_screen.dart';
import 'package:first_app_flutter/views/login/login_view_model.dart';
import 'package:first_app_flutter/views/register/register_screen.dart';
import 'package:first_app_flutter/views/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const bool isDevMode = bool.fromEnvironment('dart.vm.product') == false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.signInAnonymously();

  if (isDevMode) {
    // FirebaseFirestore.instance.useFirestoreEmulator('10.0.2.2', 8080);
    // await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ItemService()),
        ChangeNotifierProvider(create: (_) => TransactionService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream:
          FirebaseAuth.instance.authStateChanges(), // Dengarkan status login
      builder: (context, snapshot) {
        // Sementara loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        // Jika user sudah login, arahkan ke Home
        final bool isLoggedIn = snapshot.hasData;

        return ShadApp(
          debugShowCheckedModeBanner: false,
          theme: ShadThemeData(
            brightness: Brightness.light,
            colorScheme: const ShadNeutralColorScheme.light(),
          ),
          themeMode: ThemeMode.light,
          initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
          routes: {
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.register: (context) => const RegisterScreen(),
            AppRoutes.home: (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
