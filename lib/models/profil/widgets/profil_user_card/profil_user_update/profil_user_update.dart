import 'package:flutter/material.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ProfilUserUpdate extends StatefulWidget {
  const ProfilUserUpdate({Key? key}) : super(key: key);

  @override
  State<ProfilUserUpdate> createState() => _ProfilUserUpdateState();
}

class _ProfilUserUpdateState extends State<ProfilUserUpdate> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            child: InputCustom(
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
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              label: const Text(
                'Email : ',
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
