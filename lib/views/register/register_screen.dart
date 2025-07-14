import 'package:first_app_flutter/routes/app_routes.dart';
import 'package:first_app_flutter/views/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final registerViewModel = Provider.of<RegisterViewModel>(context);

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
                    'Register',
                    style: TextStyle(
                      fontSize: theme.textTheme.h1Large.fontSize,
                      fontWeight: theme.textTheme.h3.fontWeight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please fill email and password to Register.',
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
                                initialValue: registerViewModel.email,
                                onChanged: (value) =>
                                    registerViewModel.setEmail(value),
                              ),
                              const SizedBox(height: 16),
                              ShadInputFormField(
                                label: const Text("Password"),
                                placeholder: const Text("Enter your password"),
                                obscureText: true,
                                initialValue: registerViewModel.password,
                                onChanged: (value) =>
                                    registerViewModel.setPassword(value),
                              ),
                              const SizedBox(height: 16),
                              ShadButton(
                                width: double.infinity,
                                onPressed: () async {
                                  final success = await registerViewModel
                                      .registerWithEmailAndPassword();

                                  if (success && context.mounted) {
                                    ShadToaster.of(context).show(
                                      const ShadToast(
                                        title: Text('Register Success'),
                                        description: Text(
                                          'Please login with your email and password',
                                        ),
                                      ),
                                    );
                                    registerViewModel.reset();
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.login,
                                    );
                                  } else {
                                    if (context.mounted) {
                                      ShadToaster.of(context).show(
                                        ShadToast.destructive(
                                          title: const Text('Register Failed'),
                                          description: Text(
                                            registerViewModel.errorMessage ??
                                                'Something went wrong',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text('Register'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Have an account? '),
                        ShadButton.link(
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            'Sign in',
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
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
