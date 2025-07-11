import 'package:first_app_flutter/routes/app_routes.dart';
import 'package:first_app_flutter/views/home/home_screen.dart';
import 'package:first_app_flutter/views/home/home_view_model.dart';
// import 'package:first_app_flutter/views/login/login_screen.dart';
import 'package:first_app_flutter/views/login/login_shadcn_screen.dart';
import 'package:first_app_flutter/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// pemanggil class
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(
        colorScheme: const ShadSlateColorScheme.light(),
        brightness: Brightness.light,
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginShadcnScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
      },
    );
  }
}
