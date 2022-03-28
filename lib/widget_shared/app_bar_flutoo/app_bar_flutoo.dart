import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/auth/auth_state.dart';
import 'package:flutoo/utils/services/fireauth/fireauth_service.dart';
import 'package:flutoo/widget_shared/app_bar_flutoo/switch_mode_dark.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarFlutoo extends ConsumerStatefulWidget with PreferredSizeWidget {
  const AppBarFlutoo({Key? key}) : super(key: key);

  @override
  _AppBarFlutooState createState() => _AppBarFlutooState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarFlutooState extends ConsumerState<AppBarFlutoo> {
  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(auth).asData;

    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Flutoo'),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              authUser!.value != null ?
              authUser.when(
                data: (data) {
                  return IconButton(
                    onPressed: () async {
                      /// petit load à la deconnection
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      await ref.watch(authState).disconnectAuth();
                      Navigator.pushNamed(context, Routes().home);
                    },
                    icon: const Icon(Icons.logout),
                  );
                },
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
              ) : Container(),

              /// btn switch mode dark
              const SwitchModeDark(),
            ],
          ),
        ),
      ],
    );
  }
}
