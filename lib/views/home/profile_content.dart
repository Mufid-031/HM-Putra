import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final auth = FirebaseAuth.instance;
    final user = FirebaseAuth.instance.currentUser!;

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.accentForeground,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(150),
                      ),
                      border: Border.all(
                        color: theme.colorScheme.accentForeground,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.person,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              user.displayName ?? 'Ahmad Mufid Risqi',
                              style: TextStyle(
                                fontSize: theme.textTheme.h4.fontSize,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.email,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              user.email ?? 'No email',
                              style: TextStyle(
                                fontSize: theme.textTheme.h4.fontSize,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 250),
                        ShadButton(
                          width: double.infinity,
                          onPressed: () async {
                            await auth.signOut();
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.login,
                              );
                            }
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontWeight: theme.textTheme.h3.fontWeight,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
