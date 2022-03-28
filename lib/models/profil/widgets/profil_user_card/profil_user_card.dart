import 'package:flutoo/models/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilUserCard extends ConsumerStatefulWidget {
  const ProfilUserCard({Key? key}) : super(key: key);

  @override
  _ProfilUserCardState createState() => _ProfilUserCardState();
}

class _ProfilUserCardState extends ConsumerState<ProfilUserCard> {
  bool seeUpdate = false;

  /// affiche/cache volet update user
  void openCloseUpdated() {
    setState(() {
      seeUpdate = !seeUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// recupere le user current
    final user = ref.watch(userCurrent);

    return Container(
      child: Column(
        children: [
          
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              'Nom : ' + user!.firstName!,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              'Prénom : ' + user.lastName!,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              'Pseudo : ' + user.pseudo!,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              'Email : '+ user.email!,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
