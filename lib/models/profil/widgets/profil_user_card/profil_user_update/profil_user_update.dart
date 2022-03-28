import 'package:flutoo/models/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:woo_widget_input/woo_widget_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilUserUpdate extends ConsumerStatefulWidget {
  const ProfilUserUpdate({Key? key}) : super(key: key);

  @override
  _ProfilUserUpdateState createState() => _ProfilUserUpdateState();
}

class _ProfilUserUpdateState extends ConsumerState<ProfilUserUpdate> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userCurrent);

    return SizedBox(
      width: 500,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            child: InputCustom(
              initialValue: user!.firstName!,
              label: const Text(
                'Nom : ',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: InputCustom(
              initialValue: user.lastName!,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              label: const Text(
                'Prénom : ',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: InputCustom(
              initialValue: user.pseudo!,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              label: const Text(
                'Pseudo : ',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: InputCustom(
              initialValue: user.email!,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              label: const Text(
                'Email : ' ,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
