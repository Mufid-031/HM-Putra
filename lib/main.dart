import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/routes/app_routes.dart';
// import 'package:first_app_flutter/views/home/home_screen.dart';
import 'package:first_app_flutter/views/home/home_shadcn_screen.dart';
import 'package:first_app_flutter/views/home/home_view_model.dart';
// import 'package:first_app_flutter/views/login/login_screen.dart';
import 'package:first_app_flutter/views/login/login_shadcn_screen.dart';
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

  if (isDevMode) {
    await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadNeutralColorScheme.light(),
      ),
      // darkTheme: ShadThemeData(
      //   brightness: Brightness.dark,
      //   colorScheme: const ShadNeutralColorScheme.dark(),
      // ),
      initialRoute: AppRoutes.login,
      themeMode: ThemeMode.light,
      routes: {
        AppRoutes.login: (context) => const LoginShadcnScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.home: (context) => const HomeShadcnScreen(),
      },
    );
  }
}
