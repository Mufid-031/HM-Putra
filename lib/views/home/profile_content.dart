import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  _launchURL(String url) async {
    final Uri url0 = Uri.parse(url);
    if (await launchUrl(url0)) {
      await launchUrl(url0);
    } else {
      throw 'Could not launch $url0';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final auth = FirebaseAuth.instance;
    final user = FirebaseAuth.instance.currentUser;

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
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/yuzuha.jpg',
                        ),
                        fit: BoxFit.cover,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
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
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                ),
                                SizedBox(width: 15),
                                Text('Name'),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 40,
                                top: 10,
                                bottom: 20,
                              ),
                              child: Text(
                                user?.displayName ?? 'Ahmad Mufid Risqi',
                                style: TextStyle(
                                  fontSize: theme.textTheme.p.fontSize,
                                ),
                              ),
                            ),
                            const Divider(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.email,
                                    ),
                                    SizedBox(width: 15),
                                    Text('Email'),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                    top: 10,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    user?.email ?? 'risqimufid50@gmail.com',
                                    style: TextStyle(
                                      fontSize: theme.textTheme.p.fontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Row(
                                  children: <Widget>[
                                    Icon(
                                      LucideIcons.github,
                                    ),
                                    SizedBox(width: 15),
                                    Text('Github'),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                    top: 10,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    user?.email ??
                                        'https://github.com/Mufid-031',
                                    style: TextStyle(
                                      fontSize: theme.textTheme.p.fontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Row(
                                  children: <Widget>[
                                    Icon(
                                      LucideIcons.globe,
                                    ),
                                    SizedBox(width: 15),
                                    Text('Portfolio'),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                    top: 10,
                                    bottom: 20,
                                  ),
                                  child: GestureDetector(
                                    onTap: () => _launchURL(
                                        'https://coding-with-mufid.vercel.app'),
                                    child: Text(
                                      'https://coding-with-mufid.vercel.app',
                                      style: TextStyle(
                                        fontSize: theme.textTheme.p.fontSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ShadButton(
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
