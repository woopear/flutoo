import 'package:flutoo/config/routes/routes.dart';
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
  UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Flutoo'),
      actions: [
        Container(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<UserProvider>().disconnectUserCurrent();
                    Navigator.pushNamed(context, Routes().home);
                  },
                  icon: const Icon(Icons.logout),
                ),
                const SwitchModeDark(),
              ],
            ))
      ],
    );
  }
}
