import 'package:first_app_flutter/routes/app_routes.dart';
import 'package:first_app_flutter/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: theme.textTheme.h1Large.fontSize,
                      fontWeight: theme.textTheme.h3.fontWeight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please enter your email and password to login.',
                    style: TextStyle(
                      fontSize: theme.textTheme.p.fontSize,
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.accent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 80),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              ShadInputFormField(
                                label: const Text("Email"),
                                placeholder: const Text("Enter your email"),
                                initialValue: loginViewModel.email,
                                onChanged: (value) =>
                                    loginViewModel.setEmail(value),
                              ),
                              const SizedBox(height: 16),
                              ShadInputFormField(
                                label: const Text("Password"),
                                placeholder: const Text("Enter your password"),
                                obscureText: true,
                                initialValue: loginViewModel.password,
                                onChanged: (value) =>
                                    loginViewModel.setPassword(value),
                              ),
                              const SizedBox(height: 16),
                              ShadButton(
                                width: double.infinity,
                                onPressed: () async {
                                  final success = await loginViewModel.login();

                                  if (success && context.mounted) {
                                    ShadToaster.of(context).show(
                                      const ShadToast(
                                        title: Text('Login Success'),
                                        description: Text(
                                          'Have a nice day',
                                        ),
                                      ),
                                    );
                                    loginViewModel.reset();
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.home,
                                    );
                                  } else {
                                    if (context.mounted) {
                                      ShadToaster.of(context).show(
                                        ShadToast.destructive(
                                          title: const Text('Login Failed'),
                                          description: Text(
                                            loginViewModel.errorMessage ??
                                                'Something went wrong',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text('Login'),
                              ),
                              const SizedBox(height: 16),
                              ShadButton(
                                width: double.infinity,
                                onPressed: () {
                                  loginViewModel.loginAnonymous;

                                  if (context.mounted) {
                                    ShadToaster.of(context).show(
                                      const ShadToast(
                                        title: Text('Login Success'),
                                        description: Text(
                                          'Have a nice day',
                                        ),
                                      ),
                                    );
                                    loginViewModel.reset();
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.home,
                                    );
                                  }
                                },
                                child: const Text('Login as Guest'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Don\'t have an account?'),
                        ShadButton.link(
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            'Sign up',
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.register,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}