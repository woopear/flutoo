import 'package:flutoo/models/auth/auth_state.dart';
import 'package:flutoo/models/profil/widgets/profil_user_card/profil_user_card.dart';
import 'package:flutoo/models/profil/widgets/profil_user_card/profil_user_update/profil_user_update.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/routes/routes.dart';

class ProfilUser extends ConsumerStatefulWidget {
  const ProfilUser({Key? key}) : super(key: key);

  @override
  _ProfilUserState createState() => _ProfilUserState();
}

class _ProfilUserState extends ConsumerState<ProfilUser> {
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

  /// delete le user
  void deleteUser(BuildContext context, String id) {
    ref.watch(userState).delete(id);
    ref.watch(authState).deleteAuth();
    Navigator.pushNamed(context, Routes().home);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userCurrent);
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
          Container(
            width: 500,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: Column(
              children: [
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
                  ],
                ),
                seeUpdate
                    ? ProfilUserUpdate(
                        closedUpdated: () => openCloseUpdated(),
                      )
                    : const ProfilUserCard(),
                !seeUpdate
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 40, top: 20),
                        child: ElevatedButton(
                          onPressed: () => {deleteUser(context, user!.id!)},
                          child: const Text(
                            'Effacer le compte',
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
