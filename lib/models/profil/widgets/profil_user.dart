import 'package:flutoo/models/profil/widgets/profil_user_card/profil_user_card.dart';
import 'package:flutoo/models/profil/widgets/profil_user_card/profil_user_update/profil_user_update.dart';
import 'package:flutter/material.dart';

class ProfilUser extends StatefulWidget {
  const ProfilUser({Key? key}) : super(key: key);

  @override
  State<ProfilUser> createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  bool seeUpdate = false;
  bool seeUpdateAvatar = false;

  /// affiche/cache volet update user
  void openCloseUpdated() {
    setState(() {
      seeUpdate = !seeUpdate;
    });
  }

  /// affiche/cache volet update user
  void openCloseUpdatedAvatar() {
    setState(() {
      seeUpdateAvatar = !seeUpdateAvatar;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: const Text(
              "Profil de l'utilisateur",
              style: TextStyle(fontSize: 28),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  const Icon(Icons.person, size: 100),
              seeUpdateAvatar
                  ? Container(
                      child: Align(
                        child: IconButton(
                          iconSize: 15,
                          alignment: const Alignment(0, -4),
                          onPressed: () {
                            openCloseUpdatedAvatar();
                          },
                          color: Colors.red,
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Align(
                        child: IconButton(
                          iconSize: 15,
                          alignment: const Alignment(0, -4),
                          onPressed: () {
                            openCloseUpdatedAvatar();
                          },
                          color: Theme.of(context).colorScheme.primary,
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                      ),
                    )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              seeUpdate
                  ? Container(
                      child: Align(
                        child: IconButton(
                          onPressed: () {
                            openCloseUpdated();
                          },
                          color: Colors.red,
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Align(
                        child: IconButton(
                          onPressed: () {
                            openCloseUpdated();
                          },
                          color: Theme.of(context).colorScheme.primary,
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                width: 400,
              ),
            ],
          ),
          seeUpdate ? ProfilUserUpdate(
            closedUpdated: () => openCloseUpdated(),
          ) 
          : const ProfilUserCard(),
        ],
      ),
    );
  }
}
