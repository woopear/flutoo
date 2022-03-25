import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/auth/auth_provider.dart';
import 'package:flutoo/models/user/user_provider.dart';
import 'package:flutoo/widget_shared/app_bar_flutoo/switch_mode_dark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarFlutoo extends StatefulWidget with PreferredSizeWidget {
  const AppBarFlutoo({Key? key}) : super(key: key);

  @override
  State<AppBarFlutoo> createState() => _AppBarFlutooState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarFlutooState extends State<AppBarFlutoo> {
  @override
  Widget build(BuildContext context) {
    /// ecouteur de auth connecter
    final auth = context.watch<AuthProvider>().authenticate;

    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Flutoo'),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              /// si user connecter on affiche
              /// déconnexion sinon on affiche rien
              auth != null
                  ? IconButton(
                      onPressed: () async {
                        /// petit load à la connexion
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        await context
                            .read<AuthProvider>()
                            .disconnectUserCurrent();
                        context.read<UserProvider>().resetUser();
                        Navigator.pushNamed(context, Routes().home);
                      },
                      icon: const Icon(Icons.logout),
                    )
                  : Container(),

              /// btn switch mode dark
              const SwitchModeDark(),
            ],
          ),
        ),
      ],
    );
  }
}
